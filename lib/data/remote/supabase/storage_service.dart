import 'dart:io';
import 'supabase_client.dart';

class StorageService {
  static const _publicBucket = 'items-images';
  static const _privateBucket = 'items-images-private';
  static const _docsBucket = 'items-documents';

  Future<String> uploadItemImage({
    required String itemId,
    required String imageType,
    required File file,
    bool isPublic = false,
  }) async {
    final userId = supabase.auth.currentUser!.id;
    final ext = file.path.split('.').last;
    final path = '$userId/$itemId/${imageType}_${DateTime.now().millisecondsSinceEpoch}.$ext';
    final bucket = isPublic ? _publicBucket : _privateBucket;

    await supabase.storage.from(bucket).upload(path, file);
    return path;
  }

  String getPublicUrl(String storagePath) =>
      supabase.storage.from(_publicBucket).getPublicUrl(storagePath);

  Future<String> getSignedUrl(String storagePath, {bool isDocument = false}) async {
    final bucket = isDocument ? _docsBucket : _privateBucket;
    return supabase.storage
        .from(bucket)
        .createSignedUrl(storagePath, 3600); // 1-hour TTL
  }

  Future<void> deleteImage(String storagePath, {bool isPublic = false}) async {
    final bucket = isPublic ? _publicBucket : _privateBucket;
    await supabase.storage.from(bucket).remove([storagePath]);
  }

  Future<String> uploadDocument({
    required String itemId,
    required File file,
    required String filename,
  }) async {
    final userId = supabase.auth.currentUser!.id;
    final path = '$userId/$itemId/$filename';
    await supabase.storage.from(_docsBucket).upload(path, file);
    return path;
  }
}
