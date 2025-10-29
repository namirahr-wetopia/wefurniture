import 'package:flutter/material.dart';
import 'model/inventory_model.dart';
import 'package:go_router/go_router.dart';
import 'nav.dart';
import 'view/home_screen/home.dart';
import 'view/profile_screen/profile.dart';
import 'view/welcome.dart';
import 'view/cart_screen/cart.dart';
import 'view/product_details.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _homeKey = GlobalKey<NavigatorState>();
final _favKey = GlobalKey<NavigatorState>();
final _scanKey = GlobalKey<NavigatorState>();
final _cartKey = GlobalKey<NavigatorState>();
final _profileKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/onboarding',
  routes: [
    // Onboarding (outside the shell)
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: SafeArea(child: navigationShell),
          bottomNavigationBar: AppBottomNavBar(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeKey,
          routes: [GoRoute(path: '/home', builder: (context, _) => const HomeScreen())],
        ),
        StatefulShellBranch(
          navigatorKey: _favKey,
          routes: [GoRoute(path: '/favourite', builder: (context, _) => const HomeScreen())],
        ),
        StatefulShellBranch(
          navigatorKey: _scanKey,
          routes: [GoRoute(path: '/scan', builder: (context, _) => const HomeScreen())],
        ),
        StatefulShellBranch(
          navigatorKey: _profileKey,
          routes: [GoRoute(path: '/profile', builder: (context, _) => const ProfileScreen())],
        ),
      ],
     ),
      GoRoute(
        path: '/product',
        parentNavigatorKey: _rootKey,
        pageBuilder: (context, state) {
          final product = state.extra as InventoryModel; 
          return MaterialPage(
            fullscreenDialog: true,
            child: ProductDetails(product: product),
          );
        },
      ),
      GoRoute(
        path: '/cart',
        parentNavigatorKey: _rootKey,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: true,
          child: CartScreen(),
        ),
      ),
    ]
);
