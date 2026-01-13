import 'package:flutter/material.dart';
import 'package:project_lighthouse/core/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? assetIconPath;

  const CustomAppBar({
    super.key,
    this.title = 'Proxilyt',
    this.assetIconPath = 'assets/icon.png',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(
            assetIconPath!,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 12),
          Text(title!),
        ],
      ),
      backgroundColor: AppColors.background,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
