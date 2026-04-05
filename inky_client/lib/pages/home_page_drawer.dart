import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../widgets/avatar_widget.dart';
import 'add_book_page.dart';
import 'my_library_page.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key, this.onBookAdded});

  final VoidCallback? onBookAdded;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const _HomePageDrawerHeader(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Добавить произведение'),
            onTap: () async {
              Navigator.of(context).pop();
              final wasAdded = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (context) => const AddBookPage()),
              );

              if (wasAdded == true) {
                onBookAdded?.call();
              }
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Мои произведения'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyLibraryPage()),
              );
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
    );
  }
}

class _HomePageDrawerHeader extends StatelessWidget {
  const _HomePageDrawerHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DrawerHeader(
        decoration: const BoxDecoration(color: AppStyles.headerColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AvatarWidget(
                onTap: () {
                  // TODO: Implement profile tap action
                },
                radius: 30,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Имя Фамилия',
              style: TextStyle(
                color: AppStyles.textAboveHeaderColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
