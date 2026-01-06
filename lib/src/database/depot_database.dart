import "package:drift/drift.dart";
import "package:flutter/foundation.dart";
import "package:mapplet/src/database/database_schema.dart";
import "package:mapplet/src/database/depot_stats.dart";
import "package:mapplet/src/depot/depot_config.dart";
import "package:queue/queue.dart";

/// The depot database of **Mapplet**, migrated to Drift.
///
/// This facade wraps the [AppDatabase] and handles batch operations,
/// region management, and statistical reporting.
@internal
class DepotDatabase {
  DepotDatabase._(this.config, this.db);

  final DepotConfiguration config;
  late final AppDatabase db;

  late final Queue _writeQueue = Queue(parallel: config.writeWorkers);
  final List<String> _batchesUrls = List<String>.empty(growable: true);

  /// Initialize the Drift database instance with the given [DepotConfiguration]
  static Future<DepotDatabase> open(DepotConfiguration config) async {
    // Note: AppDatabase handles its own connection opening based on the logic
    final database = AppDatabase();
    var data = DepotDatabase._(config, database);

    Future<void> cleanupUnlinked() async {
      // In Drift/SQL, we delete tiles where links <= 0
      final query = data.db.delete(data.db.tiles)..where((t) => t.links.isSmallerOrEqualValue(0));
      await query.go();
    }

    if (config.cleanUnlinkedTilesOnInit) {
      var cleanup = cleanupUnlinked();
      if (config.awaitUnlinkedTileClenOnInit) {
        await cleanup;
      }
    }
    return data;
  }

  Future<void> clear() async {
    await db.dropAllTables();
  }

  /// Close the database connection
  Future<void> close() async {
    await db.close();
  }

  /// Add a single tile to the database
  Future<void> writeSingleTile(Tile tile) async {
    await db.into(db.tiles).insertOnConflictUpdate(
          TilesCompanion.insert(
            url: tile.url,
            bytes: tile.bytes,
            links: Value(tile.links),
            timestamp: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
          ),
        );
  }

  /// Delete the given [regionId] from the db
  ///
  /// Updates link counts for associated tiles and removes the region.
  Future<bool> deleteRegion(String regionId) async {
    try {
      await db.transaction(() async {
        // 1. Get all tiles associated with this region
        final regionTilesQuery = db.select(db.regionTiles)..where((t) => t.regionId.equals(regionId));
        final associations = await regionTilesQuery.get();

        for (final assoc in associations) {
          // 2. Decrement link count or delete if it's the last one
          final tileQuery = db.select(db.tiles)..where((t) => t.url.equals(assoc.tileUrl));
          final tile = await tileQuery.getSingleOrNull();

          if (tile != null) {
            if (tile.links > 1) {
              await (db.update(db.tiles)..where((t) => t.url.equals(tile.url))).write(
                TilesCompanion(links: Value(tile.links - 1)),
              );
            } else {
              // Mark for deletion or delete immediately
              await (db.delete(db.tiles)..where((t) => t.url.equals(tile.url))).go();
            }
          }
        }

        // 3. Delete the region-tile associations and the region itself
        await (db.delete(db.regionTiles)..where((t) => t.regionId.equals(regionId))).go();
        await (db.delete(db.regions)..where((t) => t.regionId.equals(regionId))).go();
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Clean the temporary tracked URLs for batch operations
  Future<void> cleanTemp({bool purgeUnlinkedTiles = true}) async {
    _batchesUrls.clear();
    if (purgeUnlinkedTiles) {
      final query = db.delete(db.tiles)..where((t) => t.links.isSmallerOrEqualValue(0));
      await query.go();
    }
  }

  /// Runs a batch write transaction for tiles
  Future<void> enqueueBatchWriteTx(List<Tile> tilesToSave) async {
    Future<void> batchWriteTx() async {
      await db.transaction(() async {
        for (final tile in tilesToSave) {
          // Check if tile exists to preserve/update link count
          final existing = await (db.select(db.tiles)..where((t) => t.url.equals(tile.url))).getSingleOrNull();

          await db.into(db.tiles).insertOnConflictUpdate(
                TilesCompanion.insert(
                  url: tile.url,
                  bytes: tile.bytes,
                  links: Value(existing?.links ?? 0),
                  timestamp: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
                ),
              );
          _batchesUrls.add(tile.url);
        }
      });
    }

    return _writeQueue.add(batchWriteTx);
  }

  /// Commit all tracked tiles to a specific region
  Future<bool> commitRegionTx(String regionId) async {
    await _writeQueue.onComplete;
    try {
      await db.transaction(() async {
        // 1. Ensure region exists
        await db.into(db.regions).insertOnConflictUpdate(RegionsCompanion.insert(regionId: regionId));

        for (final url in _batchesUrls) {
          // 2. Increment links for the tiles being committed
          final tile = await (db.select(db.tiles)..where((t) => t.url.equals(url))).getSingleOrNull();
          if (tile != null) {
            await (db.update(db.tiles)..where((t) => t.url.equals(url))).write(
              TilesCompanion(links: Value(tile.links + 1)),
            );

            // 3. Create association
            await db.into(db.regionTiles).insertOnConflictUpdate(
                  RegionTilesCompanion.insert(regionId: regionId, tileUrl: url),
                );
          }
        }
      });
      _batchesUrls.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Returns Tiles linked with the given [regionId]
  Future<Iterable<Tile>> getRegionTiles(String regionId) async {
    return await db.getTilesForRegion(regionId);
  }

  /// Returns the Tiles matching the given [urls]
  Future<List<Tile?>> getTilesByUrl(Iterable<String> urls) async {
    final query = db.select(db.tiles)..where((t) => t.url.isIn(urls));
    final results = await query.get();

    // Maintain order and nulls as per original Isar getAll implementation
    final resultMap = {for (final t in results) t.url: t};
    return urls.map((url) => resultMap[url]).toList();
  }

  /// Returns a single tile by URL
  Future<Tile?> getSingleTileByUrl(String url) async {
    return await (db.select(db.tiles)..where((t) => t.url.equals(url))).getSingleOrNull();
  }

  /// Returns all regions
  Future<List<Region>> getAllRegions() => db.select(db.regions).get();

  /// Checks if a region exists
  Future<bool> hasRegion(String regionId) async {
    final res = await (db.select(db.regions)..where((t) => t.regionId.equals(regionId))).getSingleOrNull();
    return res != null;
  }

  /// Checks if a tile exists
  Future<bool> hasTiles(String url) async {
    final res = await (db.select(db.tiles)..where((t) => t.url.equals(url))).getSingleOrNull();
    return res != null;
  }

  /// Returns the [DepotStats] of the db
  Future<DepotStats> getStats() async {
    // Note: getSize() functionality varies in SQLite;
    // we calculate counts and estimate sizes from bytes.
    final allTiles = await db.select(db.tiles).get();
    final regionCount = await db.regions.count().getSingle();

    int totalBytes = 0;
    for (final tile in allTiles) {
      totalBytes += tile.bytes.length;
    }

    return DepotStats(
      byteSize: totalBytes, // Simple estimation
      tilesBytesSize: totalBytes,
      regionsBytesSize: 0,
      tilesCount: allTiles.length,
      regionCount: regionCount,
    );
  }
}
