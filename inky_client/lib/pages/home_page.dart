import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/header_widget.dart';
import 'add_book_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderWidget(),
      body: _buildBody(),
      endDrawer: _buildDrawer(context),
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
    );
  }

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
              child: AvatarWidget(
                onTap: () {
                  print("TODO profile");
                  //TODO: Implement profile tap action
                },
                radius: 30,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Имя Фамилия',
              style: TextStyle(
                color: AppStyles.textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: 64,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 0.5,
        ),
        itemBuilder: (context, index) {
          return _buildBookItem(
            title: 'Book Name',
            author: 'Author Name',
          );
        },
      ),
    );
  }
Widget _buildBookItem({
  required String title,
  required String author,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppStyles.avatarAnonBackgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
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
    );
  }
}