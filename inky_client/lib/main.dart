import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'services/database_service.dart';
import 'styles/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseService.initializeSupabase();
  var books = await DatabaseService.loadBooks();
  print(books);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,// This line removes the banner
      title: 'Inky',
      home: const HomePage(),
    );
  }
}
