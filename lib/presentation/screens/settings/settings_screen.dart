import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../providers/auth/auth_provider.dart';
import '../../providers/items/items_provider.dart';
import '../../providers/wordpress/wordpress_provider.dart';
import '../../../core/services/export_service.dart';
import '../../../core/services/wordpress_service.dart';
import '../../../core/theme/app_colors.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Account'),
            subtitle: Text(user?.email ?? ''),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Sync status'),
            subtitle: const Text('Synced with Supabase'),
            trailing:
                const Icon(Icons.check_circle, color: AppColors.success),
          ),
          const Divider(),
          const _ExportSection(),
          const Divider(),
          const _WordPressSection(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('Sign out',
                style: TextStyle(color: AppColors.error)),
            onTap: () => _signOut(context),
          ),
          const Divider(),
          const ListTile(
            title: Text('Coin Vault',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Version 1.0.0'),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Sign out'),
              ),
            ],
          ),
        ) ??
        false;

    if (confirmed) {
      await Supabase.instance.client.auth.signOut();
    }
  }
}

class _ExportSection extends ConsumerStatefulWidget {
  const _ExportSection();

  @override
  ConsumerState<_ExportSection> createState() => _ExportSectionState();
}

class _ExportSectionState extends ConsumerState<_ExportSection> {
  bool _exportingCsv = false;
  bool _exportingPdf = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Text('Export',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                  letterSpacing: 0.5)),
        ),
        ListTile(
          leading: _exportingCsv
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.table_chart_outlined),
          title: const Text('Export as CSV'),
          subtitle: const Text('Spreadsheet — all fields, all items'),
          onTap: _exportingCsv ? null : () => _runExport(csv: true),
        ),
        ListTile(
          leading: _exportingPdf
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Icon(Icons.picture_as_pdf_outlined),
          title: const Text('Export as PDF'),
          subtitle: const Text('Formatted report — great for insurance'),
          onTap: _exportingPdf ? null : () => _runExport(csv: false),
        ),
      ],
    );
  }

  Future<void> _runExport({required bool csv}) async {
    setState(() {
      if (csv) {
        _exportingCsv = true;
      } else {
        _exportingPdf = true;
      }
    });

    try {
      // Fetch all items (no filters)
      final items = await ref.read(itemRepositoryProvider).fetchItems();
      if (!mounted) return;

      if (csv) {
        await ExportService.exportCsv(items);
      } else {
        await ExportService.exportPdf(items);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _exportingCsv = false;
          _exportingPdf = false;
        });
      }
    }
  }
}

// ── WordPress Sync Section ────────────────────────────────────────────────────

class _WordPressSection extends ConsumerStatefulWidget {
  const _WordPressSection();

  @override
  ConsumerState<_WordPressSection> createState() => _WordPressSectionState();
}

class _WordPressSectionState extends ConsumerState<_WordPressSection> {
  WordPressCredentials? _creds;
  bool _loading = true;
  bool _syncing = false;
  int _syncDone = 0;
  int _syncTotal = 0;

  @override
  void initState() {
    super.initState();
    _loadCreds();
  }

  Future<void> _loadCreds() async {
    final creds =
        await ref.read(wordPressServiceProvider).loadCredentials();
    if (mounted) setState(() { _creds = creds; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: [
              const Text('WordPress Sync',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      letterSpacing: 0.5)),
              const SizedBox(width: 8),
              if (!_loading)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _creds != null
                        ? AppColors.success.withValues(alpha: 0.15)
                        : Colors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    _creds != null ? 'Connected' : 'Not connected',
                    style: TextStyle(
                      fontSize: 11,
                      color: _creds != null ? AppColors.success : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (_loading)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        else if (_creds == null)
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Connect WordPress site'),
            subtitle: const Text('Publish your collection as a public gallery'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openConfigDialog(),
          )
        else ...[
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(_creds!.siteUrl,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14)),
            subtitle: Text(_creds!.username),
            trailing: IconButton(
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Edit credentials',
              onPressed: () => _openConfigDialog(),
            ),
          ),
          ListTile(
            leading: _syncing
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 2,
                          value: _syncTotal > 0
                              ? _syncDone / _syncTotal
                              : null,
                        ),
                        if (_syncTotal > 0)
                          Text(
                            '$_syncDone',
                            style: const TextStyle(fontSize: 9),
                          ),
                      ],
                    ),
                  )
                : const Icon(Icons.cloud_upload_outlined),
            title: const Text('Sync collection'),
            subtitle: _syncing && _syncTotal > 0
                ? Text('$_syncDone / $_syncTotal items...')
                : const Text('Push all items to WordPress'),
            onTap: _syncing ? null : _syncAll,
          ),
          ListTile(
            leading: const Icon(Icons.link_off, color: AppColors.error),
            title: const Text('Disconnect',
                style: TextStyle(color: AppColors.error)),
            onTap: _disconnect,
          ),
        ],
      ],
    );
  }

  Future<void> _openConfigDialog() async {
    final result = await showDialog<WordPressCredentials>(
      context: context,
      builder: (_) => _WordPressConfigDialog(existing: _creds),
    );
    if (result != null) {
      await ref.read(wordPressServiceProvider).saveCredentials(result);
      if (mounted) setState(() => _creds = result);
    }
  }

  Future<void> _syncAll() async {
    if (_creds == null) return;
    setState(() { _syncing = true; _syncDone = 0; _syncTotal = 0; });

    try {
      final items = await ref.read(itemRepositoryProvider).fetchItems();
      if (!mounted) return;
      setState(() => _syncTotal = items.length);

      final result = await ref.read(wordPressServiceProvider).syncAll(
        _creds!,
        items,
        onProgress: (done, total) {
          if (mounted) setState(() { _syncDone = done; _syncTotal = total; });
        },
      );

      if (mounted) {
        final msg = result.failed == 0
            ? 'Synced ${result.synced} items'
            : 'Synced ${result.synced}, failed ${result.failed}';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
          backgroundColor:
              result.failed == 0 ? AppColors.success : AppColors.error,
        ));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sync failed: $e'),
          backgroundColor: AppColors.error,
        ));
      }
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  Future<void> _disconnect() async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Disconnect WordPress?'),
            content: const Text(
                'Your credentials will be removed. Synced posts stay on your site.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.error),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Disconnect'),
              ),
            ],
          ),
        ) ??
        false;

    if (confirmed) {
      await ref.read(wordPressServiceProvider).clearCredentials();
      if (mounted) setState(() => _creds = null);
    }
  }
}

// ── Credentials config dialog ─────────────────────────────────────────────────

class _WordPressConfigDialog extends StatefulWidget {
  final WordPressCredentials? existing;
  const _WordPressConfigDialog({this.existing});

  @override
  State<_WordPressConfigDialog> createState() => _WordPressConfigDialogState();
}

class _WordPressConfigDialogState extends State<_WordPressConfigDialog> {
  late final TextEditingController _urlCtrl;
  late final TextEditingController _userCtrl;
  late final TextEditingController _passCtrl;
  bool _obscure = true;
  bool _testing = false;
  String? _testError;
  bool? _testOk;

  @override
  void initState() {
    super.initState();
    _urlCtrl = TextEditingController(text: widget.existing?.siteUrl ?? '');
    _userCtrl = TextEditingController(text: widget.existing?.username ?? '');
    _passCtrl = TextEditingController(text: widget.existing?.appPassword ?? '');
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('WordPress Credentials'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your WordPress site URL and an Application Password (Users → Profile → Application Passwords).',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlCtrl,
              keyboardType: TextInputType.url,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Site URL',
                hintText: 'https://yoursite.com',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _clearTestState(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _userCtrl,
              autocorrect: false,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _clearTestState(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _passCtrl,
              obscureText: _obscure,
              autocorrect: false,
              decoration: InputDecoration(
                labelText: 'Application Password',
                hintText: 'xxxx xxxx xxxx xxxx xxxx xxxx',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () =>
                      setState(() => _obscure = !_obscure),
                ),
              ),
              onChanged: (_) => _clearTestState(),
            ),
            if (_testError != null) ...[
              const SizedBox(height: 10),
              Text(_testError!,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12)),
            ],
            if (_testOk == true) ...[
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.check_circle, color: AppColors.success, size: 16),
                  SizedBox(width: 6),
                  Text('Connection successful',
                      style: TextStyle(
                          color: AppColors.success, fontSize: 12)),
                ],
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _testing ? null : _testConnection,
          child: _testing
              ? const SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Test'),
        ),
        FilledButton(
          onPressed: _canSave ? _save : null,
          child: const Text('Save'),
        ),
      ],
    );
  }

  bool get _canSave =>
      _urlCtrl.text.trim().isNotEmpty &&
      _userCtrl.text.trim().isNotEmpty &&
      _passCtrl.text.trim().isNotEmpty;

  void _clearTestState() =>
      setState(() { _testOk = null; _testError = null; });

  Future<void> _testConnection() async {
    setState(() { _testing = true; _testOk = null; _testError = null; });
    try {
      final creds = _buildCreds();
      final ok = await WordPressService().ping(creds);
      if (mounted) setState(() { _testOk = ok; _testError = ok ? null : 'Plugin not found — is Coin Vault installed?'; });
    } catch (e) {
      if (mounted) setState(() => _testError = 'Connection failed: $e');
    } finally {
      if (mounted) setState(() => _testing = false);
    }
  }

  void _save() => Navigator.pop(context, _buildCreds());

  WordPressCredentials _buildCreds() => WordPressCredentials(
        siteUrl: _urlCtrl.text.trim(),
        username: _userCtrl.text.trim(),
        appPassword: _passCtrl.text.trim(),
      );
}
