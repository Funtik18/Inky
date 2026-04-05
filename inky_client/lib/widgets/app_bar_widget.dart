import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      automaticallyImplyLeading: canPop,
      leading: canPop
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              color: AppStyles.textAboveHeaderColor,
            )
          : null,
      title: Text(title, style: const TextStyle(color: AppStyles.textAboveHeaderColor)),
      backgroundColor: AppStyles.headerColor,
      iconTheme: const IconThemeData(color: AppStyles.textAboveHeaderColor),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
