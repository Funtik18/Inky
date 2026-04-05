import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../widgets/app_bar_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBarWidget(title: 'Избранное'),
      body: const Center(
        child: Text('Здесь будут отображаться избранные произведения.'),
      ),
    );
  }
}
