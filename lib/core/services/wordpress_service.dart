import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../../data/models/item.dart';

class WordPressCredentials {
  final String siteUrl;
  final String username;
  final String appPassword;

  const WordPressCredentials({
    required this.siteUrl,
    required this.username,
    required this.appPassword,
  });
}

class WpSyncResult {
  final int postId;
  final String itemId;
  final String status;
  final String url;

  const WpSyncResult({
    required this.postId,
    required this.itemId,
    required this.status,
    required this.url,
  });

  factory WpSyncResult.fromJson(Map<String, dynamic> json) => WpSyncResult(
        postId: json['post_id'] as int,
        itemId: json['item_id'] as String,
        status: json['status'] as String,
        url: json['url'] as String,
      );
}

class WpSyncedItem {
  final int postId;
  final String itemId;
  final String url;
  final String status;

  const WpSyncedItem({
    required this.postId,
    required this.itemId,
    required this.url,
    required this.status,
  });

  factory WpSyncedItem.fromJson(Map<String, dynamic> json) => WpSyncedItem(
        postId: json['post_id'] as int,
        itemId: json['item_id'] as String,
        url: json['url'] as String,
        status: json['status'] as String,
      );
}

class WpBatchResult {
  final int synced;
  final int failed;
  final List<String> errors;

  const WpBatchResult({
    required this.synced,
    required this.failed,
    required this.errors,
  });
}

class WordPressService {
  static const _storage = FlutterSecureStorage();
  static const _keyUrl = 'wp_site_url';
  static const _keyUser = 'wp_username';
  static const _keyPass = 'wp_app_password';
  static const _ns = 'wp-json/coin-vault/v1';

  Future<WordPressCredentials?> loadCredentials() async {
    final url = await _storage.read(key: _keyUrl);
    final user = await _storage.read(key: _keyUser);
    final pass = await _storage.read(key: _keyPass);
    if (url == null || user == null || pass == null) return null;
    return WordPressCredentials(siteUrl: url, username: user, appPassword: pass);
  }

  Future<void> saveCredentials(WordPressCredentials creds) async {
    await Future.wait([
      _storage.write(key: _keyUrl, value: creds.siteUrl),
      _storage.write(key: _keyUser, value: creds.username),
      _storage.write(key: _keyPass, value: creds.appPassword),
    ]);
  }

  Future<void> clearCredentials() async {
    await Future.wait([
      _storage.delete(key: _keyUrl),
      _storage.delete(key: _keyUser),
      _storage.delete(key: _keyPass),
    ]);
  }

  Future<bool> ping(WordPressCredentials creds) async {
    final res = await http
        .get(Uri.parse(_url(creds, 'ping')))
        .timeout(const Duration(seconds: 10));
    return res.statusCode == 200;
  }

  Future<WpSyncResult> syncItem(WordPressCredentials creds, Item item) async {
    final res = await http
        .post(
          Uri.parse(_url(creds, 'sync')),
          headers: _headers(creds),
          body: jsonEncode(_toPayload(item)),
        )
        .timeout(const Duration(seconds: 15));

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${_extractError(res.body)}');
    }
    return WpSyncResult.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  Future<void> deleteItem(WordPressCredentials creds, String itemId) async {
    final res = await http
        .delete(
          Uri.parse(_url(creds, 'delete/$itemId')),
          headers: _headers(creds),
        )
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${_extractError(res.body)}');
    }
  }

  Future<List<WpSyncedItem>> listSynced(WordPressCredentials creds) async {
    final res = await http
        .get(Uri.parse(_url(creds, 'list')), headers: _headers(creds))
        .timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw Exception('HTTP ${res.statusCode}: ${_extractError(res.body)}');
    }
    final list = jsonDecode(res.body) as List<dynamic>;
    return list
        .map((e) => WpSyncedItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<WpBatchResult> syncAll(
    WordPressCredentials creds,
    List<Item> items, {
    void Function(int done, int total)? onProgress,
  }) async {
    int synced = 0;
    int failed = 0;
    final errors = <String>[];

    for (int i = 0; i < items.length; i++) {
      try {
        await syncItem(creds, items[i]);
        synced++;
      } catch (e) {
        failed++;
        errors.add('${items[i].id}: $e');
      }
      onProgress?.call(i + 1, items.length);
    }

    return WpBatchResult(synced: synced, failed: failed, errors: errors);
  }

  // ── Private helpers ───────────────────────────────────────────────────

  String _url(WordPressCredentials creds, String path) {
    final base = creds.siteUrl.endsWith('/')
        ? creds.siteUrl.substring(0, creds.siteUrl.length - 1)
        : creds.siteUrl;
    return '$base/$_ns/$path';
  }

  Map<String, String> _headers(WordPressCredentials creds) {
    final token =
        base64Encode(utf8.encode('${creds.username}:${creds.appPassword}'));
    return {
      'Authorization': 'Basic $token',
      'Content-Type': 'application/json',
    };
  }

  Map<String, dynamic> _toPayload(Item item) => {
        'id': item.id,
        'item_type': item.itemType,
        'country': item.country,
        'issuing_authority': item.issuingAuthority,
        'denomination': item.denomination,
        'denomination_numeric': item.denominationNumeric,
        'year_start': item.yearStart,
        'year_end': item.yearEnd,
        'mint_mark': item.mintMark,
        'series': item.series,
        'variety': item.variety,
        'is_public': item.isPublic,
        'metal': item.metal,
        'weight_grams': item.weightGrams,
        'diameter_mm': item.diameterMm,
        'edge_type': item.edgeType,
        'coin_orientation': item.coinOrientation,
        'obverse_description': item.obverseDescription,
        'reverse_description': item.reverseDescription,
        'edge_description': item.edgeDescription,
        'die_markers': item.dieMarkers,
        'grade': item.grade,
        'grade_numeric': item.gradeNumeric,
        'grading_company': item.gradingCompany,
        'cert_number': item.certNumber,
        'is_slabbed': item.isSlabbed,
        'details_grade': item.detailsGrade,
        'designation': item.designation,
        'population_obverse': item.populationObverse,
        'population_reverse': item.populationReverse,
        'submission_status': item.submissionStatus,
        'quantity': item.quantity,
        'duplicate_count': item.duplicateCount,
        'historical_context': item.historicalContext,
        'attribution_notes': item.attributionNotes,
        'provenance': item.provenance,
        'internal_notes': item.internalNotes,
      };

  String _extractError(String body) {
    try {
      final j = jsonDecode(body) as Map<String, dynamic>;
      return j['message'] as String? ?? body;
    } catch (_) {
      return body;
    }
  }
}
