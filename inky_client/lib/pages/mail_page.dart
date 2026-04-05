import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import '../widgets/app_bar_widget.dart';

class MailPage extends StatefulWidget {
  const MailPage({super.key});

  @override
  State<MailPage> createState() => _MailPageState();
}

class _MailPageState extends State<MailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBarWidget(title: 'Почта'),
      body: const Center(
        child: Text('Здесь будут отображаться ваши сообщения.'),
      ),
    );
  }
}
