import 'package:flutter/material.dart';
import 'package:inky_client/services/database_service.dart';
import '../styles/app_colors.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWidget(),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppStyles.primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: AvatarWidget(radius: 30),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Имя Фамилия',
                      style: TextStyle(color: AppStyles.textColor, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: const Text('Create New Book'),
              onTap: () {
                DatabaseService.addBook();
              },
            ),
          ],
        ),
      ),
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
    );
  }
}
