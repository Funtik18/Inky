import 'package:flutter/material.dart';
import 'package:inky_client/services/database_service.dart';
import '../styles/app_colors.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/header_widget.dart';
import 'add_book_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildHeader() {
    return SizedBox(
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: AppStyles.primaryColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AvatarWidget( onTap: () {
                print("TODO profile");
                //TODO: Implement profile tap action
              }, radius: 30),
            ),
            const SizedBox(height: 8),
            const Text(
              'Имя Фамилия',
              style: TextStyle(color: AppStyles.textColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _buildHeader(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Добавить произведение'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBookPage()),
                );
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Мои книги'),
              onTap: () {
                // Handle my books tap
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Избранное'),
              onTap: () {
                // Handle favorites tap
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Настройки'),
              onTap: () {
                // Handle settings tap
              },
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Выйти'),
              onTap: () {
                // Handle logout tap
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
