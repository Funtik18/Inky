import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../styles/app_assets.dart';
import '../styles/app_colors.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/header_widget.dart';
import 'add_book_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Map<String, dynamic>>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = DatabaseService.loadBooks();
  }

  void _reloadBooks() {
    setState(() {
      _booksFuture = DatabaseService.loadBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
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
          color: AppStyles.headerColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AvatarWidget(
                onTap: () {
                  //TODO: Implement profile tap action
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

  Widget _buildBody() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _booksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Ошибка загрузки книг: ${snapshot.error}'),
            ),
          );
        }

        final books = snapshot.data ?? [];

        if (books.isEmpty) {
          return const Center(
            child: Text('Книг пока нет'),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.5,
            ),
            itemBuilder: (context, index) {
              final book = books[index];

              return _buildBookItem(
                title: (book['title'] ?? '').toString(),
                author: (book['author'] ?? '').toString(),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBookItem({required String title, required String author}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                AppAssets.blankCover,
                width: double.infinity,
                fit: BoxFit.cover,
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
            onTap: () async {
              Navigator.of(context).pop();
              final wasAdded = await Navigator.push<bool>(
                context,
                MaterialPageRoute(builder: (context) => const AddBookPage()),
              );

              if (wasAdded == true) {
                _reloadBooks();
              }
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
