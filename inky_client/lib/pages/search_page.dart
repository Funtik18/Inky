import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../widgets/app_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBarWidget(title: 'Поиск'),
      body: const Center(child: Text('Здесь будет доступен поиск.')),
    );
  }
}
