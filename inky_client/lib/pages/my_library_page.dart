import 'package:flutter/material.dart';

import '../styles/app_colors.dart';

class MyLibraryPage extends StatelessWidget {
  const MyLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: AppStyles.textAboveHeaderColor,
        title: const Text('Мои произведения'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Это твоя библиотека, пока пустая.\nДобавь произведение, чтобы оно появилось здесь!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
