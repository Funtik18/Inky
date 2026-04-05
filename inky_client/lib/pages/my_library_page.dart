import 'package:flutter/material.dart';

import '../services/database_service.dart';
import '../styles/app_colors.dart';
import '../widgets/book_card_widget.dart';
import '../widgets/app_bar_widget.dart';

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
    _booksFuture = DatabaseService.loadBooks(isAscending: false);
  }

  Future<void> _reloadBooks() async {
    setState(() {
      _booksFuture = DatabaseService.loadBooks(isAscending: false);
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
      appBar: AppBarWidget(title: 'Моя библиотека'),
      body: _buildBody(),
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

                return BookCardWidget(
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
}
