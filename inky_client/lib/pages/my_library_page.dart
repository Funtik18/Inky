import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/bucket_service.dart';
import '../services/database_service.dart';
import '../styles/app_assets.dart';
import '../styles/app_colors.dart';
import '../widgets/header_widget.dart';
import 'home_page_drawer.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({super.key});

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  late Future<List<Map<String, dynamic>>> _booksFuture;

  @override
  void initState() {
    super.initState();
    _booksFuture = DatabaseService.loadBooks();
  }

  Future<void> _reloadBooks() async {
    setState(() {
      _booksFuture = DatabaseService.loadBooks();
    });

    await _booksFuture;
  }

  Widget _buildRefreshWrapper({required Widget child}) {
    return RefreshIndicator(onRefresh: _reloadBooks, child: child);
  }

  Widget _buildScrollableMessage(String text) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(text, textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: HeaderWidget(onReload: () => _reloadBooks()),
      body: _buildBody(),
      endDrawer: HomePageDrawer(onBookAdded: () => _reloadBooks()),
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
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
          return _buildRefreshWrapper(
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(
                    child: Text('Ошибка загрузки книг: ${snapshot.error}'),
                  ),
                ),
              ],
            ),
          );
        }

        final books = snapshot.data ?? [];

        if (books.isEmpty) {
          return _buildRefreshWrapper(
            child: _buildScrollableMessage(
              'Это твоя библиотека, пока пустая.\nДобавь произведение, чтобы оно появилось здесь!',
            ),
          );
        }

        return _buildRefreshWrapper(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
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
                  coverUrl: (book['cover_url'] ?? '').toString(),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookItem({
    required String title,
    required String author,
    required String coverUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FutureBuilder<Uint8List?>(
                future: BucketService.loadCoverImage(coverUrl),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Image.memory(
                      snapshot.data!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }

                  return Image.asset(
                    AppAssets.blankCover,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
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
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
