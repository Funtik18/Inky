import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import 'avatar_widget.dart';

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppStyles.primaryColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AvatarWidget(
            radius: 20,
            onTap: () {
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