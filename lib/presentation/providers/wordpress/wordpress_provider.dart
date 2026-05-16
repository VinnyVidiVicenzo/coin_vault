import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/wordpress_service.dart';

final wordPressServiceProvider =
    Provider<WordPressService>((_) => WordPressService());

final wordPressCredentialsProvider =
    FutureProvider<WordPressCredentials?>((ref) {
  return ref.read(wordPressServiceProvider).loadCredentials();
});
