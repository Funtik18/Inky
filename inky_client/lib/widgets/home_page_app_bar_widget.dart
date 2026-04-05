import 'package:flutter/material.dart';

import '../pages/mail_page.dart';
import '../pages/notification_page.dart';
import '../pages/search_page.dart';
import '../styles/app_colors.dart';
import 'avatar_widget.dart';

class HomePageAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const HomePageAppBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: AppStyles.textAboveHeaderColor),
      ),
      backgroundColor: AppStyles.headerColor,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
          icon: const Icon(Icons.search),
          color: AppStyles.textAboveHeaderColor,
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MailPage()),
            );
          },
          icon: const Icon(Icons.mail_outline),
          color: AppStyles.textAboveHeaderColor,
        ),
        IconButton(
          icon: const Icon(Icons.notifications_none),
          color: AppStyles.textAboveHeaderColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationPage()),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: AvatarWidget(
            radius: 20,
            onTap: () {
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
