import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback? onTap;

  const ProfileOption({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color:Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.05,
            vertical: w * 0.03,
          ),
          child: Row(
            children: [
              Container(
                width: w * 0.107,
                height: w * 0.107,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              SizedBox(width: w * 0.04),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.darkestGray,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, size: 30, color: AppColors.darkestGray),
            ],
          ),
        ),
      ),
    );
  }
}
