import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/scaffold_with_nav_bar.dart';
import '../../features/auth/sign_in_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/library/library_screen.dart';
import '../../features/review/review_screen.dart';
import '../../features/review/session_complete_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/article/article_detail_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String signIn = '/sign-in';
  static const String home = '/home';
  static const String library = '/library';
  static const String review = '/review';
  static const String profile = '/profile';
  static const String articleDetail = '/article/:id';
  static const String sessionComplete = '/session-complete';
}

class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey =
      GlobalKey<NavigatorState>(debugLabel: 'home');
  static final _shellNavigatorLibraryKey =
      GlobalKey<NavigatorState>(debugLabel: 'library');
  static final _shellNavigatorProfileKey =
      GlobalKey<NavigatorState>(debugLabel: 'profile');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.signIn,
    routes: [
      // Sign-in (full screen, no nav bar)
      GoRoute(
        path: AppRoutes.signIn,
        name: 'signIn',
        builder: (context, state) => const SignInScreen(),
      ),

      // Bottom-nav shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorLibraryKey,
            routes: [
              GoRoute(
                path: AppRoutes.library,
                name: 'library',
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // Full-screen routes (above the shell, no nav bar)
      GoRoute(
        path: AppRoutes.review,
        name: 'review',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ReviewScreen(),
      ),
      GoRoute(
        path: AppRoutes.articleDetail,
        name: 'articleDetail',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final articleId = state.pathParameters['id'] ?? '';
          return ArticleDetailScreen(articleId: articleId);
        },
      ),
      GoRoute(
        path: AppRoutes.sessionComplete,
        name: 'sessionComplete',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SessionCompleteScreen(),
      ),
    ],
  );
}
