import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../models/item.dart';

part 'app_database.g.dart';

class CachedItemRows extends Table {
  TextColumn get id => text()();
  TextColumn get jsonData => text()();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [CachedItemRows])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() =>
      driftDatabase(name: 'coin_vault_cache');

  // ── Write ─────────────────────────────────────────────────

  Future<void> cacheItem(Item item) => into(cachedItemRows).insertOnConflictUpdate(
        CachedItemRowsCompanion.insert(
          id: item.id,
          jsonData: jsonEncode(item.toJson()),
          cachedAt: DateTime.now(),
        ),
      );

  Future<void> cacheItems(List<Item> items) async {
    await batch((b) {
      b.insertAll(
        cachedItemRows,
        items
            .map((item) => CachedItemRowsCompanion.insert(
                  id: item.id,
                  jsonData: jsonEncode(item.toJson()),
                  cachedAt: DateTime.now(),
                ))
            .toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteCachedItem(String id) =>
      (delete(cachedItemRows)..where((t) => t.id.equals(id))).go();

  // ── Read ──────────────────────────────────────────────────

  Future<Item?> getCachedItem(String id) async {
    final row = await (select(cachedItemRows)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return null;
    return _decode(row.jsonData);
  }

  Future<List<Item>> getCachedItems({
    String? itemType,
    String? country,
    String? gradingCompany,
    bool? isSlabbed,
    String? series,
    double? minGrade,
    double? maxGrade,
    String? mintMark,
    int? minYear,
    int? maxYear,
    String sortBy = 'date_added',
    int limit = 50,
    int offset = 0,
  }) async {
    final rows = await select(cachedItemRows).get();
    var items = rows.map((r) => _decode(r.jsonData)).toList();

    if (itemType != null) {
      items = items.where((i) => i.itemType == itemType).toList();
    }
    if (country != null) {
      final q = country.toLowerCase();
      items = items
          .where((i) => i.country?.toLowerCase().contains(q) == true)
          .toList();
    }
    if (gradingCompany != null) {
      items =
          items.where((i) => i.gradingCompany == gradingCompany).toList();
    }
    if (isSlabbed != null) {
      items = items.where((i) => i.isSlabbed == isSlabbed).toList();
    }
    if (series != null) {
      final q = series.toLowerCase();
      items = items
          .where((i) => i.series?.toLowerCase().contains(q) == true)
          .toList();
    }
    if (minGrade != null) {
      items = items
          .where((i) => i.gradeNumeric != null && i.gradeNumeric! >= minGrade)
          .toList();
    }
    if (maxGrade != null) {
      items = items
          .where((i) => i.gradeNumeric != null && i.gradeNumeric! <= maxGrade)
          .toList();
    }
    if (mintMark != null) {
      final q = mintMark.toLowerCase();
      items = items
          .where((i) => i.mintMark?.toLowerCase().contains(q) == true)
          .toList();
    }
    if (minYear != null) {
      items = items
          .where((i) => i.yearStart != null && i.yearStart! >= minYear)
          .toList();
    }
    if (maxYear != null) {
      items = items
          .where((i) => i.yearStart != null && i.yearStart! <= maxYear)
          .toList();
    }

    items.sort((a, b) {
      switch (sortBy) {
        case 'year':
          return (a.yearStart ?? 0).compareTo(b.yearStart ?? 0);
        case 'grade':
          return (b.gradeNumeric ?? 0).compareTo(a.gradeNumeric ?? 0);
        default:
          return 0;
      }
    });

    return items.skip(offset).take(limit).toList();
  }

  Future<List<Item>> searchCachedItems(String query) async {
    final rows = await select(cachedItemRows).get();
    final q = query.toLowerCase();
    return rows
        .map((r) => _decode(r.jsonData))
        .where((item) =>
            item.denomination?.toLowerCase().contains(q) == true ||
            item.country?.toLowerCase().contains(q) == true ||
            item.series?.toLowerCase().contains(q) == true ||
            item.variety?.toLowerCase().contains(q) == true ||
            item.grade?.toLowerCase().contains(q) == true ||
            item.issuingAuthority?.toLowerCase().contains(q) == true)
        .toList();
  }

  Item _decode(String json) => Item.fromJson(
        (jsonDecode(json) as Map<String, dynamic>),
      );
}
