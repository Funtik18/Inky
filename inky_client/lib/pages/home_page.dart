import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../widgets/header_widget.dart';
import 'home_page_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: HeaderWidget(),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Главная страница.\nОткрой "Мои произведения" в меню, чтобы посмотреть библиотеку.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      endDrawer: const HomePageDrawer(),
      drawerEnableOpenDragGesture: true,
      endDrawerEnableOpenDragGesture: true,
    );
  }
}
