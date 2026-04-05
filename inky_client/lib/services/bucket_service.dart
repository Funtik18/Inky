import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class BucketService {
  /*static Future<Map<String, dynamic>> loadCatalog() async {
    final response = await http.get(
      //Uri.parse('https://inky.s3.amazonaws.com/catalog/books.json'), 
      Uri.parse('https://d9bjv0wyrf9ss.cloudfront.net/catalog/books.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load catalog');
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }*/

  static final Map<String, Future<Uint8List?>> _coverCache = {};

  static Future<Uint8List?> loadCoverImage(String coverUrl) {
    final normalizedUrl = coverUrl.trim();
    if (normalizedUrl.isEmpty) {
      return Future.value(null);
    }

    return _coverCache.putIfAbsent(normalizedUrl, () async {
      final response = await http.get(Uri.parse(normalizedUrl));
      if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
        return null;
      }
      return response.bodyBytes;
    });
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