import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../widgets/app_bar_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBarWidget(title: 'Уведомления'),
      body: const Center(
        child: Text('Здесь будут отображаться ваши уведомления.'),
      ),
    );
  }
}