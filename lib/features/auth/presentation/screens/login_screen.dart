import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/role_selector_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      _navigateByRole(context, state.user.role);
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Expanded(child: Text(state.message)),
            ],
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  void _navigateByRole(BuildContext context, String role) {
    switch (role) {
      case AppConstants.roleAdmin:
        Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
        break;
      case AppConstants.rolePrincipal:
        Navigator.of(context).pushReplacementNamed(AppRoutes.principalDashboard);
        break;
      case AppConstants.roleTeacher:
        Navigator.of(context).pushReplacementNamed(AppRoutes.teacherDashboard);
        break;
      case AppConstants.roleStudent:
        Navigator.of(context).pushReplacementNamed(AppRoutes.studentDashboard);
        break;
    }
  }

  void _submit(BuildContext context) {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(AppStrings.errorRoleRequired),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().login(
            email: _emailController.text,
            password: _passwordController.text,
            selectedRole: _selectedRole!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _onAuthState,
        builder: (context, state) {
          final isLoading = state is AuthOperationLoading;

          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ─── Header ─────────────────────────────────────────────
                    _buildHeader().animate().fadeIn(duration: 500.ms),

                    // ─── Form Card ──────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.all(AppConstants.paddingLarge),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Role Selector
                            RoleSelectorWidget(
                              selectedRole: _selectedRole,
                              onRoleSelected: (role) {
                                setState(() => _selectedRole = role);
                              },
                            ).animate().fadeIn(delay: 100.ms, duration: 400.ms),

                            const SizedBox(height: 28),

                            // Email
                            AppTextField(
                              label: AppStrings.emailLabel,
                              hint: AppStrings.emailHint,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: Icons.alternate_email_rounded,
                              validator: Validators.validateEmail,
                              textInputAction: TextInputAction.next,
                            ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                            const SizedBox(height: 20),

                            // Password
                            AppTextField(
                              label: AppStrings.passwordLabel,
                              hint: AppStrings.passwordHint,
                              controller: _passwordController,
                              isPassword: true,
                              prefixIcon: Icons.lock_outline_rounded,
                              validator: Validators.validatePassword,
                              textInputAction: TextInputAction.done,
                            ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

                            const SizedBox(height: 12),

                            // Forgot Password
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppStrings.forgotPassword,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(delay: 350.ms, duration: 400.ms),

                            const SizedBox(height: 24),

                            // Login Button
                            AppButton(
                              label: AppStrings.loginButton,
                              isLoading: isLoading,
                              onPressed: isLoading ? null : () => _submit(context),
                            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 40),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          // Logo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
            ),
            child: const Center(
              child: Text(
                'أ',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            AppStrings.loginTitle,
            style: AppTextStyles.headlineLarge.copyWith(color: Colors.white),
          ),

          const SizedBox(height: 8),

          Text(
            AppStrings.loginSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
