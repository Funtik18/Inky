import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import 'avatar_widget.dart';

class AppBarAvatarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarAvatarWidget({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: AppStyles.textAboveHeaderColor)),
      backgroundColor: AppStyles.headerColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AvatarWidget(
            radius: 20,
            onTap: onTap ??() {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
      iconTheme: const IconThemeData(color: AppStyles.textAboveHeaderColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
