import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';

class RoleSelectorWidget extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String> onRoleSelected;

  const RoleSelectorWidget({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  static const List<_RoleItem> _roles = [
    _RoleItem(
      role: AppConstants.roleAdmin,
      label: AppStrings.roleAdmin,
      description: AppStrings.roleAdminDesc,
      icon: Icons.admin_panel_settings_outlined,
      gradient: AppColors.adminGradient,
    ),
    _RoleItem(
      role: AppConstants.rolePrincipal,
      label: AppStrings.rolePrincipal,
      description: AppStrings.rolePrincipalDesc,
      icon: Icons.business_outlined,
      gradient: AppColors.principalGradient,
    ),
    _RoleItem(
      role: AppConstants.roleTeacher,
      label: AppStrings.roleTeacher,
      description: AppStrings.roleTeacherDesc,
      icon: Icons.school_outlined,
      gradient: AppColors.teacherGradient,
    ),
    _RoleItem(
      role: AppConstants.roleStudent,
      label: AppStrings.roleStudent,
      description: AppStrings.roleStudentDesc,
      icon: Icons.person_outlined,
      gradient: AppColors.studentGradient,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.selectRole, style: AppTextStyles.titleMedium),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.6,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _roles.length,
          itemBuilder: (context, index) {
            final item = _roles[index];
            final isSelected = selectedRole == item.role;
            return _RoleCard(
              item: item,
              isSelected: isSelected,
              onTap: () => onRoleSelected(item.role),
            ).animate().fadeIn(
                  delay: Duration(milliseconds: 80 * index),
                  duration: 300.ms,
                );
          },
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final _RoleItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: isSelected ? item.gradient : null,
          color: isSelected ? null : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.border,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: item.gradient.colors.first.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: 26,
              color: isSelected ? Colors.white : AppColors.textSecondary,
            ),
            const SizedBox(height: 6),
            Text(
              item.label,
              style: AppTextStyles.labelLarge.copyWith(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              item.description,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? Colors.white70 : AppColors.textHint,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleItem {
  final String role;
  final String label;
  final String description;
  final IconData icon;
  final LinearGradient gradient;

  const _RoleItem({
    required this.role,
    required this.label,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}
