import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'presentation/providers/auth/auth_provider.dart';
import 'presentation/providers/core_providers.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';
import 'presentation/screens/items/item_list_screen.dart';
import 'presentation/screens/items/item_detail_screen.dart';
import 'presentation/screens/items/item_form_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/valuation/add_valuation_screen.dart';
import 'presentation/screens/valuation/valuation_history_screen.dart';
import 'presentation/screens/ebay/ebay_listing_screen.dart';
import 'presentation/screens/storage/storage_screen.dart';
import 'presentation/screens/search/search_screen.dart';
import 'core/theme/app_theme.dart';

final _routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/dashboard',
    redirect: (context, state) {
      final isAuthenticated = authState.valueOrNull?.session != null;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginRoute) return '/login';
      if (isAuthenticated && isLoginRoute) return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      ShellRoute(
        builder: (context, state, child) => _AppShell(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (_, _) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/collection',
            builder: (_, _) => const ItemListScreen(),
          ),
          GoRoute(
            path: '/items/new',
            builder: (_, _) => const ItemFormScreen(),
          ),
          GoRoute(
            path: '/items/:id',
            builder: (_, state) =>
                ItemDetailScreen(itemId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'edit',
                builder: (_, state) => ItemFormScreen(
                  itemId: state.pathParameters['id'],
                ),
              ),
              GoRoute(
                path: 'valuation',
                builder: (_, state) => ValuationHistoryScreen(
                    itemId: state.pathParameters['id']!),
                routes: [
                  GoRoute(
                    path: 'add',
                    builder: (_, state) => AddValuationScreen(
                        itemId: state.pathParameters['id']!),
                  ),
                ],
              ),
              GoRoute(
                path: 'ebay',
                builder: (_, state) => EbayListingScreen(
                    itemId: state.pathParameters['id']!),
              ),
            ],
          ),
          GoRoute(
            path: '/search',
            builder: (_, _) => const SearchScreen(),
          ),
          GoRoute(
            path: '/storage',
            builder: (_, _) => const StorageScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (_, _) => const SettingsScreen(),
          ),
          GoRoute(
            path: '/integrations/ebay',
            builder: (_, _) => const _PlaceholderScreen('eBay Integration'),
          ),
          GoRoute(
            path: '/integrations/wordpress',
            builder: (_, _) =>
                const _PlaceholderScreen('WordPress Integration'),
          ),
        ],
      ),
    ],
  );
});

class CoinVaultApp extends ConsumerWidget {
  const CoinVaultApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);

    return MaterialApp.router(
      title: 'Coin Vault',
      theme: AppTheme.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class _AppShell extends ConsumerStatefulWidget {
  final Widget child;
  const _AppShell({required this.child});

  @override
  ConsumerState<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<_AppShell> {
  int _selectedIndex = 0;

  static const _destinations = [
    (icon: Icons.dashboard_outlined, label: 'Dashboard', route: '/dashboard'),
    (icon: Icons.inventory_2_outlined, label: 'Collection', route: '/collection'),
    (icon: Icons.search, label: 'Search', route: '/search'),
    (icon: Icons.location_on_outlined, label: 'Storage', route: '/storage'),
    (icon: Icons.settings_outlined, label: 'Settings', route: '/settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;
    final onlineAsync = ref.watch(onlineStreamProvider);
    final isOffline = onlineAsync.valueOrNull == false;

    Widget buildContent() {
      if (isWide) {
        return Scaffold(
          body: Row(
            children: [
              // Dark futuristic sidebar
              Container(
                width: 72,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF0A0E27), Color(0xFF141B45)],
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFBB00).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFFFBB00).withValues(alpha: 0.3)),
                      ),
                      child: const Icon(Icons.monetization_on,
                          color: Color(0xFFFFBB00), size: 22),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Colors.white10, height: 1),
                    const SizedBox(height: 8),
                    ..._destinations.asMap().entries.map((e) {
                      final selected = _selectedIndex == e.key;
                      return Tooltip(
                        message: e.value.label,
                        preferBelow: false,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedIndex = e.key);
                            context.go(e.value.route);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 52,
                            height: 52,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0xFFFFBB00).withValues(alpha: 0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(14),
                              border: selected
                                  ? Border.all(
                                      color: const Color(0xFFFFBB00)
                                          .withValues(alpha: 0.4))
                                  : null,
                            ),
                            child: Icon(
                              e.value.icon,
                              color: selected
                                  ? const Color(0xFFFFBB00)
                                  : Colors.white.withValues(alpha: 0.4),
                              size: 22,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Expanded(child: widget.child),
            ],
          ),
        );
      }

      // Bottom navigation for phones
      return Scaffold(
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (i) {
            setState(() => _selectedIndex = i);
            context.go(_destinations[i].route);
          },
          destinations: _destinations
              .map((d) => NavigationDestination(
                    icon: Icon(d.icon),
                    label: d.label,
                  ))
              .toList(),
        ),
      );
    }

    return Column(
      children: [
        if (isOffline) const _OfflineBanner(),
        Expanded(child: buildContent()),
      ],
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFFF8C00),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 14, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  'You\'re offline — browsing cached collection',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for screens not yet built (Phase 2/3)
class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Text('$title — coming soon',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      );
}
