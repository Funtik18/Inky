import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import 'avatar_widget.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key, this.onTap, this.onReload});

  final VoidCallback? onTap;
  final VoidCallback? onReload;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppStyles.primaryColor,
      actions: [
        if (onReload != null)
          IconButton(
            onPressed: onReload,
            icon: const Icon(Icons.refresh),
            color: AppStyles.textAboveHeaderColor,
            tooltip: 'Обновить',
          ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AvatarWidget(
            radius: 20,
            onTap:
                onTap ??
                () {
                  Scaffold.of(context).openEndDrawer();
                },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
