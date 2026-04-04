import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import '../widgets/header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const HeaderWidget(),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Text('Menu'),
                ),
              ),
              ListTile(
                title: const Text('Create New Book'),
                onTap: () {
                  // Handle item 1 tap
                },
              ),
            ],
          ),
        ),
        drawerEnableOpenDragGesture: true,
        endDrawerEnableOpenDragGesture: true,
    );
  }
}
