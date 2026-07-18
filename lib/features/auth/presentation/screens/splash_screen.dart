import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/routing/app_routes.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _slideAnim;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnim = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnim = Tween<double>(begin: 30, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAuthState(BuildContext context, AuthState state) {
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted) {
        if (state is AuthAuthenticated) {
          _navigateByRole(context, state.user.role);
        } else if (state is AuthUnauthenticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      }
    });
  }

  void _navigateByRole(BuildContext context, String role) {
    switch (role) {
      case AppConstants.roleAdmin:
        Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
        break;
      case AppConstants.rolePrincipal:
        Navigator.of(
          context,
        ).pushReplacementNamed(AppRoutes.principalDashboard);
        break;
      case AppConstants.roleTeacher:
        Navigator.of(context).pushReplacementNamed(AppRoutes.teacherDashboard);
        break;
      case AppConstants.roleStudent:
        Navigator.of(context).pushReplacementNamed(AppRoutes.studentDashboard);
        break;
      default:
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>()..checkAuthStatus(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: _onAuthState,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(gradient: AppColors.splashGradient),
            child: SafeArea(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Transform.scale(
                          scale: _scaleAnim.value,
                          child: Opacity(
                            opacity: _fadeAnim.value,
                            child: _buildLogo(),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // App name
                        Transform.translate(
                          offset: Offset(0, _slideAnim.value),
                          child: Opacity(
                            opacity: _fadeAnim.value,
                            child: _buildTextContent(),
                          ),
                        ),

                        const SizedBox(height: 80),

                        // Loading indicator
                        Opacity(
                          opacity: _fadeAnim.value,
                          child: const SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white60,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          'أثر',
          style: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontFamily: 'Cairo',
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      children: [
        Text(AppStrings.appName, style: AppTextStyles.appName),
        const SizedBox(height: 10),
        Text(
          AppStrings.appTagline,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white70,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          AppStrings.appDescription,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.white54,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
