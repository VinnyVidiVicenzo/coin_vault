// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedItemRowsTable extends CachedItemRows
    with TableInfo<$CachedItemRowsTable, CachedItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedItemRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonDataMeta = const VerificationMeta(
    'jsonData',
  );
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
    'json_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, jsonData, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_item_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(
        _jsonDataMeta,
        jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      jsonData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_data'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedItemRowsTable createAlias(String alias) {
    return $CachedItemRowsTable(attachedDatabase, alias);
  }
}

class CachedItemRow extends DataClass implements Insertable<CachedItemRow> {
  final String id;
  final String jsonData;
  final DateTime cachedAt;
  const CachedItemRow({
    required this.id,
    required this.jsonData,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['json_data'] = Variable<String>(jsonData);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedItemRowsCompanion toCompanion(bool nullToAbsent) {
    return CachedItemRowsCompanion(
      id: Value(id),
      jsonData: Value(jsonData),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedItemRow(
      id: serializer.fromJson<String>(json['id']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'jsonData': serializer.toJson<String>(jsonData),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedItemRow copyWith({String? id, String? jsonData, DateTime? cachedAt}) =>
      CachedItemRow(
        id: id ?? this.id,
        jsonData: jsonData ?? this.jsonData,
        cachedAt: cachedAt ?? this.cachedAt,
      );
  CachedItemRow copyWithCompanion(CachedItemRowsCompanion data) {
    return CachedItemRow(
      id: data.id.present ? data.id.value : this.id,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedItemRow(')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonData, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedItemRow &&
          other.id == this.id &&
          other.jsonData == this.jsonData &&
          other.cachedAt == this.cachedAt);
}

class CachedItemRowsCompanion extends UpdateCompanion<CachedItemRow> {
  final Value<String> id;
  final Value<String> jsonData;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedItemRowsCompanion({
    this.id = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedItemRowsCompanion.insert({
    required String id,
    required String jsonData,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       jsonData = Value(jsonData),
       cachedAt = Value(cachedAt);
  static Insertable<CachedItemRow> custom({
    Expression<String>? id,
    Expression<String>? jsonData,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonData != null) 'json_data': jsonData,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedItemRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? jsonData,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedItemRowsCompanion(
      id: id ?? this.id,
      jsonData: jsonData ?? this.jsonData,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedItemRowsCompanion(')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedItemRowsTable cachedItemRows = $CachedItemRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedItemRows];
}

typedef $$CachedItemRowsTableCreateCompanionBuilder =
    CachedItemRowsCompanion Function({
      required String id,
      required String jsonData,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedItemRowsTableUpdateCompanionBuilder =
    CachedItemRowsCompanion Function({
      Value<String> id,
      Value<String> jsonData,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$CachedItemRowsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedItemRowsTable> {
  $$CachedItemRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedItemRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedItemRowsTable> {
  $$CachedItemRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedItemRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedItemRowsTable> {
  $$CachedItemRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedItemRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedItemRowsTable,
          CachedItemRow,
          $$CachedItemRowsTableFilterComposer,
          $$CachedItemRowsTableOrderingComposer,
          $$CachedItemRowsTableAnnotationComposer,
          $$CachedItemRowsTableCreateCompanionBuilder,
          $$CachedItemRowsTableUpdateCompanionBuilder,
          (
            CachedItemRow,
            BaseReferences<_$AppDatabase, $CachedItemRowsTable, CachedItemRow>,
          ),
          CachedItemRow,
          PrefetchHooks Function()
        > {
  $$CachedItemRowsTableTableManager(
    _$AppDatabase db,
    $CachedItemRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedItemRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedItemRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedItemRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> jsonData = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedItemRowsCompanion(
                id: id,
                jsonData: jsonData,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String jsonData,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedItemRowsCompanion.insert(
                id: id,
                jsonData: jsonData,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedItemRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedItemRowsTable,
      CachedItemRow,
      $$CachedItemRowsTableFilterComposer,
      $$CachedItemRowsTableOrderingComposer,
      $$CachedItemRowsTableAnnotationComposer,
      $$CachedItemRowsTableCreateCompanionBuilder,
      $$CachedItemRowsTableUpdateCompanionBuilder,
      (
        CachedItemRow,
        BaseReferences<_$AppDatabase, $CachedItemRowsTable, CachedItemRow>,
      ),
      CachedItemRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedItemRowsTableTableManager get cachedItemRows =>
      $$CachedItemRowsTableTableManager(_db, _db.cachedItemRows);
}
