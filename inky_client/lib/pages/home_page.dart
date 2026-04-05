import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/bucket_service.dart';
import '../services/database_service.dart';
import '../styles/app_assets.dart';
import '../styles/app_colors.dart';
import '../widgets/header_widget.dart';
import 'home_page_drawer.dart';

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

  Future<void> _reloadBooks() async {
    setState(() {
      _booksFuture = DatabaseService.loadBooks();
    });

    await _booksFuture;
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
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Ошибка загрузки книг: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final books = (snapshot.data ?? []).reversed.take(10).toList();

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          children: [
            _buildSectionHeader(),
            const SizedBox(height: 16),
            if (books.isEmpty)
              _buildEmptyState()
            else
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return SizedBox(
                      width: 150,
                      child: _buildBookItem(
                        title: (book['title'] ?? '').toString(),
                        author: (book['author'] ?? '').toString(),
                        coverUrl: (book['cover_url'] ?? '').toString(),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Новые поступления',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppStyles.textColor,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Только что опубликованные произведения',
                style: TextStyle(fontSize: 13, color: AppStyles.subtitleColor),
              ),
            ],
          ),
        ),
        TextButton(onPressed: () {}, child: const Text('ВСЕ')),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppStyles.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'Пока нет новых поступлений',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: AppStyles.subtitleColor),
      ),
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
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppStyles.shadowColor,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppStyles.textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Text(
              author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppStyles.subtitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
