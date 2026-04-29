import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';

// ──────────────────────────────────────────────────────────────
// SETUP INSTRUCTIONS:
// 1. Create a project at https://supabase.com
// 2. Run supabase/migrations/001_initial_schema.sql in the SQL editor
// 3. Create storage buckets: items-images (public), items-images-private, items-documents
// 4. Replace the placeholder values below with your project's URL and anon key
//    (found in: Project Settings → API)
// ──────────────────────────────────────────────────────────────

const _supabaseUrl = 'https://YOUR_PROJECT_ID.supabase.co';
const _supabaseAnonKey = 'YOUR_ANON_KEY';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: _supabaseUrl,
    anonKey: _supabaseAnonKey,
  );

  runApp(const ProviderScope(child: CoinVaultApp()));
}
