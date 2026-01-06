import "dart:io";

import "package:drift/drift.dart";
import "package:drift/native.dart";
import "package:path/path.dart" as p;
import "package:path_provider/path_provider.dart";

part "database_schema.g.dart";

/// Table representing the TileModel
class Tiles extends Table {
  // Use URL as the primary key since it was your hash base in Isar
  TextColumn get url => text()();
  IntColumn get timestamp => integer().clientDefault(() => DateTime.now().toUtc().millisecondsSinceEpoch)();
  IntColumn get links => integer().withDefault(const Constant(0))();
  BlobColumn get bytes => blob()();

  @override
  Set<Column> get primaryKey => {url};
}

/// Table representing the RegionModel
class Regions extends Table {
  TextColumn get regionId => text()();

  @override
  Set<Column> get primaryKey => {regionId};
}

/// Join table for the many-to-many relationship between Regions and Tiles
class RegionTiles extends Table {
  TextColumn get regionId => text().references(Regions, #regionId)();
  TextColumn get tileUrl => text().references(Tiles, #url)();

  @override
  Set<Column> get primaryKey => {regionId, tileUrl};
}

@DriftDatabase(tables: [Tiles, Regions, RegionTiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- MIGRATED CORE FUNCTIONALITY ---

  /// Core logic: Get a list of URLs that are NOT in the database yet.
  /// This allows you to fetch only what is missing.
  Future<List<String>> getMissingTileUrls(List<String> urlsToCheck) async {
    final query = selectOnly(tiles)..addColumns([tiles.url]);
    query.where(tiles.url.isIn(urlsToCheck));

    final existingRows = await query.get();
    final existingUrls = existingRows.map((r) => r.read(tiles.url)).toSet();

    return urlsToCheck.where((url) => !existingUrls.contains(url)).toList();
  }

  Future<void> dropAllTables() async {
    await transaction(() async {
      for (final table in allTables) {
        await delete(table).go();
      }
    });
  }

  /// Saves a new tile and links it to a region
  Future<void> saveTileToRegion(String regionId, String url, List<int> bytes) async {
    await transaction(() async {
      // 1. Ensure the region exists
      await into(regions).insertOnConflictUpdate(RegionsCompanion.insert(regionId: regionId));

      // 2. Insert or update the tile
      await into(tiles).insertOnConflictUpdate(
        TilesCompanion.insert(
          url: url,
          bytes: Uint8List.fromList(bytes),
          timestamp: Value(DateTime.now().toUtc().millisecondsSinceEpoch),
        ),
      );

      // 3. Link them in the join table
      await into(regionTiles).insertOnConflictUpdate(
        RegionTilesCompanion.insert(regionId: regionId, tileUrl: url),
      );
    });
  }

  /// Retrieves all tiles for a specific region
  Future<List<Tile>> getTilesForRegion(String regionId) async {
    final query = select(tiles).join([
      innerJoin(regionTiles, regionTiles.tileUrl.equalsExp(tiles.url)),
    ])
      ..where(regionTiles.regionId.equals(regionId));

    final rows = await query.get();
    return rows.map((row) => row.readTable(tiles)).toList();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "mapplet.sqlite"));
    return NativeDatabase.createInBackground(file);
  });
}
