import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class BucketService {
  static Future<Map<String, dynamic>> loadCatalog() async {
    final response = await http.get(
      //Uri.parse('https://inky.s3.amazonaws.com/catalog/books.json'), 
      Uri.parse('https://d9bjv0wyrf9ss.cloudfront.net/catalog/books.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load catalog');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  static Future<void> uploadFile({
    required String presignedUrl,
    required File file,
    required String contentType,
  }) async {
    final bytes = await file.readAsBytes();

    final response = await http.put(
      Uri.parse(presignedUrl),
      headers: {
        'Content-Type': contentType,
      },
      body: bytes,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Upload failed: ${response.statusCode} ${response.body}',
      );
    }
  }
}