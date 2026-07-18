import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';

class RoleBadge extends StatelessWidget {
  final String role;
  
  const RoleBadge({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    String label = '';
    Color color = AppColors.primary;

    switch (role) {
      case AppConstants.roleAdmin:
        label = AppStrings.roleAdmin;
        color = AppColors.adminColor;
        break;
      case AppConstants.rolePrincipal:
        label = AppStrings.rolePrincipal;
        color = AppColors.principalColor;
        break;
      case AppConstants.roleTeacher:
        label = AppStrings.roleTeacher;
        color = AppColors.teacherColor;
        break;
      case AppConstants.roleStudent:
        label = AppStrings.roleStudent;
        color = AppColors.studentColor;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
