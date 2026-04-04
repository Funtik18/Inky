import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loadCatalog() async {
  final response = await http.get(
    Uri.parse('https://inky.s3.amazonaws.com/catalog/books.json'),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to load catalog');
  }

  return jsonDecode(response.body) as Map<String, dynamic>;
}