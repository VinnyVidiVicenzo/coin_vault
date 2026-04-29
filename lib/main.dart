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

const _supabaseUrl = 'https://rebjxvgbitpguaftaamq.supabase.co';
const _supabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJlYmp4dmdiaXRwZ3VhZnRhYW1xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc0MzA0MDksImV4cCI6MjA5MzAwNjQwOX0.F2ZVV0hmrgt5m0aqYf8fFeaaP6ZC4Tpy7tkMzU3Y9Gg';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: _supabaseUrl,
    anonKey: _supabaseAnonKey,
  );

  runApp(const ProviderScope(child: CoinVaultApp()));
}
