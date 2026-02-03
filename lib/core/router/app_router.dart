
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/projects/presentation/pages/projects_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/admin/presentation/pages/admin_dashboard.dart';
import '../../features/projects/presentation/pages/project_details_page.dart';
import '../../features/projects/domain/entities/project.dart';
import '../../features/resume/presentation/pages/resume_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../layout/main_layout.dart';
import '../widgets/splash_page.dart';
import '../../features/blog/presentation/pages/blog_page.dart';
import '../../features/blog/presentation/pages/blog_details_page.dart';

class AppRouter {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  static final router = GoRouter(
    initialLocation: '/splash',
    observers: [
      FirebaseAnalyticsObserver(analytics: _analytics),
    ],
    redirect: (context, state) {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final bool loggingIn = state.matchedLocation == '/login';
      final bool isAdmin = state.matchedLocation.startsWith('/admin');
      final bool isSplash = state.matchedLocation == '/splash';

      if (isSplash) return null;
      if (!loggedIn && isAdmin) return '/login';
      if (loggedIn && loggingIn) return '/admin';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/projects',
            builder: (context, state) => const ProjectsPage(),
            routes: [
              GoRoute(
                path: 'details',
                builder: (context, state) {
                  final project = state.extra as Project;
                  return ProjectDetailsPage(project: project);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/admin',
            builder: (context, state) => const AdminDashboard(),
          ),
          GoRoute(
            path: '/resume',
            builder: (context, state) => const ResumePage(),
          ),
          GoRoute(
            path: '/blog',
            builder: (context, state) => const BlogPage(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return BlogDetailsPage(postId: id);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
