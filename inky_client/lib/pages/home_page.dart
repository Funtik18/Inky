import 'package:flutter/material.dart';
import 'package:inky_client/services/catalog_loader.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadCatalog(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Ошибка: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('Нет данных'),
            );
          }

          final catalog = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              catalog.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
