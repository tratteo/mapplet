// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_schema.dart';

// ignore_for_file: type=lint
class $TilesTable extends Tiles with TableInfo<$TilesTable, Tile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now().toUtc().millisecondsSinceEpoch);
  static const VerificationMeta _linksMeta = const VerificationMeta('links');
  @override
  late final GeneratedColumn<int> links = GeneratedColumn<int>(
      'links', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _bytesMeta = const VerificationMeta('bytes');
  @override
  late final GeneratedColumn<Uint8List> bytes = GeneratedColumn<Uint8List>(
      'bytes', aliasedName, false,
      type: DriftSqlType.blob, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [url, timestamp, links, bytes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tiles';
  @override
  VerificationContext validateIntegrity(Insertable<Tile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('links')) {
      context.handle(
          _linksMeta, links.isAcceptableOrUnknown(data['links']!, _linksMeta));
    }
    if (data.containsKey('bytes')) {
      context.handle(
          _bytesMeta, bytes.isAcceptableOrUnknown(data['bytes']!, _bytesMeta));
    } else if (isInserting) {
      context.missing(_bytesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {url};
  @override
  Tile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tile(
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp'])!,
      links: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}links'])!,
      bytes: attachedDatabase.typeMapping
          .read(DriftSqlType.blob, data['${effectivePrefix}bytes'])!,
    );
  }

  @override
  $TilesTable createAlias(String alias) {
    return $TilesTable(attachedDatabase, alias);
  }
}

class Tile extends DataClass implements Insertable<Tile> {
  final String url;
  final int timestamp;
  final int links;
  final Uint8List bytes;
  const Tile(
      {required this.url,
      required this.timestamp,
      required this.links,
      required this.bytes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['url'] = Variable<String>(url);
    map['timestamp'] = Variable<int>(timestamp);
    map['links'] = Variable<int>(links);
    map['bytes'] = Variable<Uint8List>(bytes);
    return map;
  }

  TilesCompanion toCompanion(bool nullToAbsent) {
    return TilesCompanion(
      url: Value(url),
      timestamp: Value(timestamp),
      links: Value(links),
      bytes: Value(bytes),
    );
  }

  factory Tile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tile(
      url: serializer.fromJson<String>(json['url']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      links: serializer.fromJson<int>(json['links']),
      bytes: serializer.fromJson<Uint8List>(json['bytes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'url': serializer.toJson<String>(url),
      'timestamp': serializer.toJson<int>(timestamp),
      'links': serializer.toJson<int>(links),
      'bytes': serializer.toJson<Uint8List>(bytes),
    };
  }

  Tile copyWith({String? url, int? timestamp, int? links, Uint8List? bytes}) =>
      Tile(
        url: url ?? this.url,
        timestamp: timestamp ?? this.timestamp,
        links: links ?? this.links,
        bytes: bytes ?? this.bytes,
      );
  Tile copyWithCompanion(TilesCompanion data) {
    return Tile(
      url: data.url.present ? data.url.value : this.url,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      links: data.links.present ? data.links.value : this.links,
      bytes: data.bytes.present ? data.bytes.value : this.bytes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tile(')
          ..write('url: $url, ')
          ..write('timestamp: $timestamp, ')
          ..write('links: $links, ')
          ..write('bytes: $bytes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(url, timestamp, links, $driftBlobEquality.hash(bytes));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tile &&
          other.url == this.url &&
          other.timestamp == this.timestamp &&
          other.links == this.links &&
          $driftBlobEquality.equals(other.bytes, this.bytes));
}

class TilesCompanion extends UpdateCompanion<Tile> {
  final Value<String> url;
  final Value<int> timestamp;
  final Value<int> links;
  final Value<Uint8List> bytes;
  final Value<int> rowid;
  const TilesCompanion({
    this.url = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.links = const Value.absent(),
    this.bytes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TilesCompanion.insert({
    required String url,
    this.timestamp = const Value.absent(),
    this.links = const Value.absent(),
    required Uint8List bytes,
    this.rowid = const Value.absent(),
  })  : url = Value(url),
        bytes = Value(bytes);
  static Insertable<Tile> custom({
    Expression<String>? url,
    Expression<int>? timestamp,
    Expression<int>? links,
    Expression<Uint8List>? bytes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (url != null) 'url': url,
      if (timestamp != null) 'timestamp': timestamp,
      if (links != null) 'links': links,
      if (bytes != null) 'bytes': bytes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TilesCompanion copyWith(
      {Value<String>? url,
      Value<int>? timestamp,
      Value<int>? links,
      Value<Uint8List>? bytes,
      Value<int>? rowid}) {
    return TilesCompanion(
      url: url ?? this.url,
      timestamp: timestamp ?? this.timestamp,
      links: links ?? this.links,
      bytes: bytes ?? this.bytes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (links.present) {
      map['links'] = Variable<int>(links.value);
    }
    if (bytes.present) {
      map['bytes'] = Variable<Uint8List>(bytes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TilesCompanion(')
          ..write('url: $url, ')
          ..write('timestamp: $timestamp, ')
          ..write('links: $links, ')
          ..write('bytes: $bytes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RegionsTable extends Regions with TableInfo<$RegionsTable, Region> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _regionIdMeta =
      const VerificationMeta('regionId');
  @override
  late final GeneratedColumn<String> regionId = GeneratedColumn<String>(
      'region_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [regionId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'regions';
  @override
  VerificationContext validateIntegrity(Insertable<Region> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('region_id')) {
      context.handle(_regionIdMeta,
          regionId.isAcceptableOrUnknown(data['region_id']!, _regionIdMeta));
    } else if (isInserting) {
      context.missing(_regionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {regionId};
  @override
  Region map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Region(
      regionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region_id'])!,
    );
  }

  @override
  $RegionsTable createAlias(String alias) {
    return $RegionsTable(attachedDatabase, alias);
  }
}

class Region extends DataClass implements Insertable<Region> {
  final String regionId;
  const Region({required this.regionId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['region_id'] = Variable<String>(regionId);
    return map;
  }

  RegionsCompanion toCompanion(bool nullToAbsent) {
    return RegionsCompanion(
      regionId: Value(regionId),
    );
  }

  factory Region.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Region(
      regionId: serializer.fromJson<String>(json['regionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'regionId': serializer.toJson<String>(regionId),
    };
  }

  Region copyWith({String? regionId}) => Region(
        regionId: regionId ?? this.regionId,
      );
  Region copyWithCompanion(RegionsCompanion data) {
    return Region(
      regionId: data.regionId.present ? data.regionId.value : this.regionId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Region(')
          ..write('regionId: $regionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => regionId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Region && other.regionId == this.regionId);
}

class RegionsCompanion extends UpdateCompanion<Region> {
  final Value<String> regionId;
  final Value<int> rowid;
  const RegionsCompanion({
    this.regionId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RegionsCompanion.insert({
    required String regionId,
    this.rowid = const Value.absent(),
  }) : regionId = Value(regionId);
  static Insertable<Region> custom({
    Expression<String>? regionId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (regionId != null) 'region_id': regionId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RegionsCompanion copyWith({Value<String>? regionId, Value<int>? rowid}) {
    return RegionsCompanion(
      regionId: regionId ?? this.regionId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (regionId.present) {
      map['region_id'] = Variable<String>(regionId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegionsCompanion(')
          ..write('regionId: $regionId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RegionTilesTable extends RegionTiles
    with TableInfo<$RegionTilesTable, RegionTile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegionTilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _regionIdMeta =
      const VerificationMeta('regionId');
  @override
  late final GeneratedColumn<String> regionId = GeneratedColumn<String>(
      'region_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES regions (region_id)'));
  static const VerificationMeta _tileUrlMeta =
      const VerificationMeta('tileUrl');
  @override
  late final GeneratedColumn<String> tileUrl = GeneratedColumn<String>(
      'tile_url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tiles (url)'));
  @override
  List<GeneratedColumn> get $columns => [regionId, tileUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'region_tiles';
  @override
  VerificationContext validateIntegrity(Insertable<RegionTile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('region_id')) {
      context.handle(_regionIdMeta,
          regionId.isAcceptableOrUnknown(data['region_id']!, _regionIdMeta));
    } else if (isInserting) {
      context.missing(_regionIdMeta);
    }
    if (data.containsKey('tile_url')) {
      context.handle(_tileUrlMeta,
          tileUrl.isAcceptableOrUnknown(data['tile_url']!, _tileUrlMeta));
    } else if (isInserting) {
      context.missing(_tileUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {regionId, tileUrl};
  @override
  RegionTile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegionTile(
      regionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region_id'])!,
      tileUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tile_url'])!,
    );
  }

  @override
  $RegionTilesTable createAlias(String alias) {
    return $RegionTilesTable(attachedDatabase, alias);
  }
}

class RegionTile extends DataClass implements Insertable<RegionTile> {
  final String regionId;
  final String tileUrl;
  const RegionTile({required this.regionId, required this.tileUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['region_id'] = Variable<String>(regionId);
    map['tile_url'] = Variable<String>(tileUrl);
    return map;
  }

  RegionTilesCompanion toCompanion(bool nullToAbsent) {
    return RegionTilesCompanion(
      regionId: Value(regionId),
      tileUrl: Value(tileUrl),
    );
  }

  factory RegionTile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegionTile(
      regionId: serializer.fromJson<String>(json['regionId']),
      tileUrl: serializer.fromJson<String>(json['tileUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'regionId': serializer.toJson<String>(regionId),
      'tileUrl': serializer.toJson<String>(tileUrl),
    };
  }

  RegionTile copyWith({String? regionId, String? tileUrl}) => RegionTile(
        regionId: regionId ?? this.regionId,
        tileUrl: tileUrl ?? this.tileUrl,
      );
  RegionTile copyWithCompanion(RegionTilesCompanion data) {
    return RegionTile(
      regionId: data.regionId.present ? data.regionId.value : this.regionId,
      tileUrl: data.tileUrl.present ? data.tileUrl.value : this.tileUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegionTile(')
          ..write('regionId: $regionId, ')
          ..write('tileUrl: $tileUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(regionId, tileUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegionTile &&
          other.regionId == this.regionId &&
          other.tileUrl == this.tileUrl);
}

class RegionTilesCompanion extends UpdateCompanion<RegionTile> {
  final Value<String> regionId;
  final Value<String> tileUrl;
  final Value<int> rowid;
  const RegionTilesCompanion({
    this.regionId = const Value.absent(),
    this.tileUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RegionTilesCompanion.insert({
    required String regionId,
    required String tileUrl,
    this.rowid = const Value.absent(),
  })  : regionId = Value(regionId),
        tileUrl = Value(tileUrl);
  static Insertable<RegionTile> custom({
    Expression<String>? regionId,
    Expression<String>? tileUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (regionId != null) 'region_id': regionId,
      if (tileUrl != null) 'tile_url': tileUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RegionTilesCompanion copyWith(
      {Value<String>? regionId, Value<String>? tileUrl, Value<int>? rowid}) {
    return RegionTilesCompanion(
      regionId: regionId ?? this.regionId,
      tileUrl: tileUrl ?? this.tileUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (regionId.present) {
      map['region_id'] = Variable<String>(regionId.value);
    }
    if (tileUrl.present) {
      map['tile_url'] = Variable<String>(tileUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegionTilesCompanion(')
          ..write('regionId: $regionId, ')
          ..write('tileUrl: $tileUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TilesTable tiles = $TilesTable(this);
  late final $RegionsTable regions = $RegionsTable(this);
  late final $RegionTilesTable regionTiles = $RegionTilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [tiles, regions, regionTiles];
}

typedef $$TilesTableCreateCompanionBuilder = TilesCompanion Function({
  required String url,
  Value<int> timestamp,
  Value<int> links,
  required Uint8List bytes,
  Value<int> rowid,
});
typedef $$TilesTableUpdateCompanionBuilder = TilesCompanion Function({
  Value<String> url,
  Value<int> timestamp,
  Value<int> links,
  Value<Uint8List> bytes,
  Value<int> rowid,
});

final class $$TilesTableReferences
    extends BaseReferences<_$AppDatabase, $TilesTable, Tile> {
  $$TilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RegionTilesTable, List<RegionTile>>
      _regionTilesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.regionTiles,
              aliasName:
                  $_aliasNameGenerator(db.tiles.url, db.regionTiles.tileUrl));

  $$RegionTilesTableProcessedTableManager get regionTilesRefs {
    final manager = $$RegionTilesTableTableManager($_db, $_db.regionTiles)
        .filter((f) => f.tileUrl.url.sqlEquals($_itemColumn<String>('url')!));

    final cache = $_typedResult.readTableOrNull(_regionTilesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TilesTableFilterComposer extends Composer<_$AppDatabase, $TilesTable> {
  $$TilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get links => $composableBuilder(
      column: $table.links, builder: (column) => ColumnFilters(column));

  ColumnFilters<Uint8List> get bytes => $composableBuilder(
      column: $table.bytes, builder: (column) => ColumnFilters(column));

  Expression<bool> regionTilesRefs(
      Expression<bool> Function($$RegionTilesTableFilterComposer f) f) {
    final $$RegionTilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.url,
        referencedTable: $db.regionTiles,
        getReferencedColumn: (t) => t.tileUrl,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegionTilesTableFilterComposer(
              $db: $db,
              $table: $db.regionTiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TilesTableOrderingComposer
    extends Composer<_$AppDatabase, $TilesTable> {
  $$TilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get links => $composableBuilder(
      column: $table.links, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<Uint8List> get bytes => $composableBuilder(
      column: $table.bytes, builder: (column) => ColumnOrderings(column));
}

class $$TilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TilesTable> {
  $$TilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get links =>
      $composableBuilder(column: $table.links, builder: (column) => column);

  GeneratedColumn<Uint8List> get bytes =>
      $composableBuilder(column: $table.bytes, builder: (column) => column);

  Expression<T> regionTilesRefs<T extends Object>(
      Expression<T> Function($$RegionTilesTableAnnotationComposer a) f) {
    final $$RegionTilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.url,
        referencedTable: $db.regionTiles,
        getReferencedColumn: (t) => t.tileUrl,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegionTilesTableAnnotationComposer(
              $db: $db,
              $table: $db.regionTiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TilesTable,
    Tile,
    $$TilesTableFilterComposer,
    $$TilesTableOrderingComposer,
    $$TilesTableAnnotationComposer,
    $$TilesTableCreateCompanionBuilder,
    $$TilesTableUpdateCompanionBuilder,
    (Tile, $$TilesTableReferences),
    Tile,
    PrefetchHooks Function({bool regionTilesRefs})> {
  $$TilesTableTableManager(_$AppDatabase db, $TilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> url = const Value.absent(),
            Value<int> timestamp = const Value.absent(),
            Value<int> links = const Value.absent(),
            Value<Uint8List> bytes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TilesCompanion(
            url: url,
            timestamp: timestamp,
            links: links,
            bytes: bytes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String url,
            Value<int> timestamp = const Value.absent(),
            Value<int> links = const Value.absent(),
            required Uint8List bytes,
            Value<int> rowid = const Value.absent(),
          }) =>
              TilesCompanion.insert(
            url: url,
            timestamp: timestamp,
            links: links,
            bytes: bytes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TilesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({regionTilesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (regionTilesRefs) db.regionTiles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (regionTilesRefs)
                    await $_getPrefetchedData<Tile, $TilesTable, RegionTile>(
                        currentTable: table,
                        referencedTable:
                            $$TilesTableReferences._regionTilesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TilesTableReferences(db, table, p0)
                                .regionTilesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tileUrl == item.url),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TilesTable,
    Tile,
    $$TilesTableFilterComposer,
    $$TilesTableOrderingComposer,
    $$TilesTableAnnotationComposer,
    $$TilesTableCreateCompanionBuilder,
    $$TilesTableUpdateCompanionBuilder,
    (Tile, $$TilesTableReferences),
    Tile,
    PrefetchHooks Function({bool regionTilesRefs})>;
typedef $$RegionsTableCreateCompanionBuilder = RegionsCompanion Function({
  required String regionId,
  Value<int> rowid,
});
typedef $$RegionsTableUpdateCompanionBuilder = RegionsCompanion Function({
  Value<String> regionId,
  Value<int> rowid,
});

final class $$RegionsTableReferences
    extends BaseReferences<_$AppDatabase, $RegionsTable, Region> {
  $$RegionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RegionTilesTable, List<RegionTile>>
      _regionTilesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.regionTiles,
              aliasName: $_aliasNameGenerator(
                  db.regions.regionId, db.regionTiles.regionId));

  $$RegionTilesTableProcessedTableManager get regionTilesRefs {
    final manager = $$RegionTilesTableTableManager($_db, $_db.regionTiles)
        .filter((f) =>
            f.regionId.regionId.sqlEquals($_itemColumn<String>('region_id')!));

    final cache = $_typedResult.readTableOrNull(_regionTilesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RegionsTableFilterComposer
    extends Composer<_$AppDatabase, $RegionsTable> {
  $$RegionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get regionId => $composableBuilder(
      column: $table.regionId, builder: (column) => ColumnFilters(column));

  Expression<bool> regionTilesRefs(
      Expression<bool> Function($$RegionTilesTableFilterComposer f) f) {
    final $$RegionTilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.regionId,
        referencedTable: $db.regionTiles,
        getReferencedColumn: (t) => t.regionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegionTilesTableFilterComposer(
              $db: $db,
              $table: $db.regionTiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RegionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RegionsTable> {
  $$RegionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get regionId => $composableBuilder(
      column: $table.regionId, builder: (column) => ColumnOrderings(column));
}

class $$RegionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegionsTable> {
  $$RegionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get regionId =>
      $composableBuilder(column: $table.regionId, builder: (column) => column);

  Expression<T> regionTilesRefs<T extends Object>(
      Expression<T> Function($$RegionTilesTableAnnotationComposer a) f) {
    final $$RegionTilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.regionId,
        referencedTable: $db.regionTiles,
        getReferencedColumn: (t) => t.regionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegionTilesTableAnnotationComposer(
              $db: $db,
              $table: $db.regionTiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RegionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RegionsTable,
    Region,
    $$RegionsTableFilterComposer,
    $$RegionsTableOrderingComposer,
    $$RegionsTableAnnotationComposer,
    $$RegionsTableCreateCompanionBuilder,
    $$RegionsTableUpdateCompanionBuilder,
    (Region, $$RegionsTableReferences),
    Region,
    PrefetchHooks Function({bool regionTilesRefs})> {
  $$RegionsTableTableManager(_$AppDatabase db, $RegionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> regionId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RegionsCompanion(
            regionId: regionId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String regionId,
            Value<int> rowid = const Value.absent(),
          }) =>
              RegionsCompanion.insert(
            regionId: regionId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$RegionsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({regionTilesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (regionTilesRefs) db.regionTiles],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (regionTilesRefs)
                    await $_getPrefetchedData<Region, $RegionsTable,
                            RegionTile>(
                        currentTable: table,
                        referencedTable:
                            $$RegionsTableReferences._regionTilesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RegionsTableReferences(db, table, p0)
                                .regionTilesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.regionId == item.regionId),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RegionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RegionsTable,
    Region,
    $$RegionsTableFilterComposer,
    $$RegionsTableOrderingComposer,
    $$RegionsTableAnnotationComposer,
    $$RegionsTableCreateCompanionBuilder,
    $$RegionsTableUpdateCompanionBuilder,
    (Region, $$RegionsTableReferences),
    Region,
    PrefetchHooks Function({bool regionTilesRefs})>;
typedef $$RegionTilesTableCreateCompanionBuilder = RegionTilesCompanion
    Function({
  required String regionId,
  required String tileUrl,
  Value<int> rowid,
});
typedef $$RegionTilesTableUpdateCompanionBuilder = RegionTilesCompanion
    Function({
  Value<String> regionId,
  Value<String> tileUrl,
  Value<int> rowid,
});

final class $$RegionTilesTableReferences
    extends BaseReferences<_$AppDatabase, $RegionTilesTable, RegionTile> {
  $$RegionTilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RegionsTable _regionIdTable(_$AppDatabase db) =>
      db.regions.createAlias(
          $_aliasNameGenerator(db.regionTiles.regionId, db.regions.regionId));

  $$RegionsTableProcessedTableManager get regionId {
    final $_column = $_itemColumn<String>('region_id')!;

    final manager = $$RegionsTableTableManager($_db, $_db.regions)
        .filter((f) => f.regionId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_regionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TilesTable _tileUrlTable(_$AppDatabase db) => db.tiles
      .createAlias($_aliasNameGenerator(db.regionTiles.tileUrl, db.tiles.url));

  $$TilesTableProcessedTableManager get tileUrl {
    final $_column = $_itemColumn<String>('tile_url')!;

    final manager = $$TilesTableTableManager($_db, $_db.tiles)
        .filter((f) => f.url.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tileUrlTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RegionTilesTableFilterComposer
    extends Composer<_$AppDatabase, $RegionTilesTable> {
  $$RegionTilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RegionsTableFilterComposer get regionId {
    final $$RegionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.regionId,
        referencedTable: $db.regions,
        getReferencedColumn: (t) => t.regionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegionsTableFilterComposer(
              $db: $db,
              $table: $db.regions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TilesTableFilterComposer get tileUrl {
    final $$TilesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tileUrl,
        referencedTable: $db.tiles,
        getReferencedColumn: (t) => t.url,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TilesTableFilterComposer(
              $db: $db,
              $table: $db.tiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RegionTilesTableOrderingComposer
    extends Composer<_$AppDatabase, $RegionTilesTable> {
  $$RegionTilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RegionsTableOrderingComposer get regionId {
    final $$RegionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.regionId,
        referencedTable: $db.regions,
        getReferencedColumn: (t) => t.regionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegionsTableOrderingComposer(
              $db: $db,
              $table: $db.regions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TilesTableOrderingComposer get tileUrl {
    final $$TilesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tileUrl,
        referencedTable: $db.tiles,
        getReferencedColumn: (t) => t.url,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TilesTableOrderingComposer(
              $db: $db,
              $table: $db.tiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RegionTilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegionTilesTable> {
  $$RegionTilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$RegionsTableAnnotationComposer get regionId {
    final $$RegionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.regionId,
        referencedTable: $db.regions,
        getReferencedColumn: (t) => t.regionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RegionsTableAnnotationComposer(
              $db: $db,
              $table: $db.regions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TilesTableAnnotationComposer get tileUrl {
    final $$TilesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tileUrl,
        referencedTable: $db.tiles,
        getReferencedColumn: (t) => t.url,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TilesTableAnnotationComposer(
              $db: $db,
              $table: $db.tiles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RegionTilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RegionTilesTable,
    RegionTile,
    $$RegionTilesTableFilterComposer,
    $$RegionTilesTableOrderingComposer,
    $$RegionTilesTableAnnotationComposer,
    $$RegionTilesTableCreateCompanionBuilder,
    $$RegionTilesTableUpdateCompanionBuilder,
    (RegionTile, $$RegionTilesTableReferences),
    RegionTile,
    PrefetchHooks Function({bool regionId, bool tileUrl})> {
  $$RegionTilesTableTableManager(_$AppDatabase db, $RegionTilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegionTilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegionTilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegionTilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> regionId = const Value.absent(),
            Value<String> tileUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RegionTilesCompanion(
            regionId: regionId,
            tileUrl: tileUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String regionId,
            required String tileUrl,
            Value<int> rowid = const Value.absent(),
          }) =>
              RegionTilesCompanion.insert(
            regionId: regionId,
            tileUrl: tileUrl,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RegionTilesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({regionId = false, tileUrl = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (regionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.regionId,
                    referencedTable:
                        $$RegionTilesTableReferences._regionIdTable(db),
                    referencedColumn: $$RegionTilesTableReferences
                        ._regionIdTable(db)
                        .regionId,
                  ) as T;
                }
                if (tileUrl) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tileUrl,
                    referencedTable:
                        $$RegionTilesTableReferences._tileUrlTable(db),
                    referencedColumn:
                        $$RegionTilesTableReferences._tileUrlTable(db).url,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RegionTilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RegionTilesTable,
    RegionTile,
    $$RegionTilesTableFilterComposer,
    $$RegionTilesTableOrderingComposer,
    $$RegionTilesTableAnnotationComposer,
    $$RegionTilesTableCreateCompanionBuilder,
    $$RegionTilesTableUpdateCompanionBuilder,
    (RegionTile, $$RegionTilesTableReferences),
    RegionTile,
    PrefetchHooks Function({bool regionId, bool tileUrl})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TilesTableTableManager get tiles =>
      $$TilesTableTableManager(_db, _db.tiles);
  $$RegionsTableTableManager get regions =>
      $$RegionsTableTableManager(_db, _db.regions);
  $$RegionTilesTableTableManager get regionTiles =>
      $$RegionTilesTableTableManager(_db, _db.regionTiles);
}
