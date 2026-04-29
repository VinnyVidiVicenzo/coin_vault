import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'presentation/providers/auth/auth_provider.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/dashboard/dashboard_screen.dart';
import 'presentation/screens/items/item_list_screen.dart';
import 'presentation/screens/items/item_detail_screen.dart';
import 'presentation/screens/items/item_form_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
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
            ],
          ),
          GoRoute(
            path: '/search',
            builder: (_, _) => const _PlaceholderScreen('Search & Filter'),
          ),
          GoRoute(
            path: '/storage',
            builder: (_, _) => const _PlaceholderScreen('Storage Manager'),
          ),
          GoRoute(
            path: '/settings',
            builder: (_, _) => const SettingsScreen(),
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
      darkTheme: AppTheme.dark,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class _AppShell extends StatefulWidget {
  final Widget child;
  const _AppShell({required this.child});

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
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

    if (isWide) {
      // Sidebar navigation for macOS / tablets
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _selectedIndex,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (i) {
                setState(() => _selectedIndex = i);
                context.go(_destinations[i].route);
              },
              destinations: _destinations
                  .map((d) => NavigationRailDestination(
                        icon: Icon(d.icon),
                        label: Text(d.label),
                      ))
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: widget.child),
          ],
        ),
      );
    }

    // Bottom navigation for Android phones
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
