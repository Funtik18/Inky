import 'dart:convert';
import 'package:http/http.dart' as http;

class LambdaService {
  static const String _baseUrl = 'https://yrxu7mzmb4o4kmdim4roi2c64y0qaati.lambda-url.us-east-1.on.aws/';

  static Future<Map<String, dynamic>> createCoverUploadUrl({
    required String fileName,
    required String contentType,
  }) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'file_name': fileName,
        'content_type': contentType,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to get presigned url: ${response.statusCode} ${response.body}',
      );
    }

    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}