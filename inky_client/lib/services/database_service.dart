import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: 'https://vsuhyruogvpcgkldhzxs.supabase.co',
      anonKey: 'sb_publishable_PNQEp0ILhXCkT3p6ATWfNw_rX9uznC3',
    );
  }

  static Future<List<Map<String, dynamic>>> loadBooks() async {
    final data = await Supabase.instance.client
        .from('books')
        .select()
        .order('created_at');

    return List<Map<String, dynamic>>.from(data);
  }

  static Future<void> addBook({
    required String author,
    required String title,
    required String annotation,
    required String notes,
    required String coverUrl,
    required bool isAdult,
    }) async {
    await Supabase.instance.client.from('books').insert({
      'author': author,
      'title': title,
      'annotation': annotation,
      'notes': notes,
      'cover_url': coverUrl,
      'is_adult': isAdult,
      //'file_url': 'https://example.com/book.epub',
    });
  }

  static Future<void> updateBookTitle(String id, String newTitle) async {
    await Supabase.instance.client
      .from('books')
      .update({'title': newTitle})
      .eq('id', id);
  }
}