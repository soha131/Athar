import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/principal/presentation/screens/principal_dashboard_screen.dart';
import '../../features/teacher/presentation/screens/teacher_dashboard_screen.dart';
import '../../features/student/presentation/screens/student_dashboard_screen.dart';
import '../../features/user_management/presentation/screens/user_management_screen.dart';
import 'app_routes.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _buildRoute(const SplashScreen(), settings);

      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);

      case AppRoutes.adminDashboard:
        return _buildRoute(const AdminDashboardScreen(), settings);

      case AppRoutes.principalDashboard:
        return _buildRoute(const PrincipalDashboardScreen(), settings);

      case AppRoutes.teacherDashboard:
        return _buildRoute(const TeacherDashboardScreen(), settings);

      case AppRoutes.studentDashboard:
        return _buildRoute(const StudentDashboardScreen(), settings);

      case AppRoutes.userManagement:
        return _buildRoute(const UserManagementScreen(), settings);

      default:
        return _buildRoute(const SplashScreen(), settings);
    }
  }

  static PageRouteBuilder<dynamic> _buildRoute(
    Widget page,
    RouteSettings settings,
  ) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }
}
