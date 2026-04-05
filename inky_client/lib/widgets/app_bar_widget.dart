import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: TextStyle(color: AppStyles.textAboveHeaderColor)),
        backgroundColor: AppStyles.headerColor,
        iconTheme: const IconThemeData(color: AppStyles.textAboveHeaderColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}