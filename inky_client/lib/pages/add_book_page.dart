import 'package:flutter/material.dart';
import 'package:inky_client/services/database_service.dart';
import '../styles/app_colors.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _annotationController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  bool _isAdultContent = false;

  @override
  void dispose() {
    _titleController.dispose();
    _annotationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Widget _buildTextFieldWithCounter({
    required TextEditingController controller,
    required String label,
    required String hint,
    required int maxLength,
    int? minLines,
    int? maxLines,
  }) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label),
                Text('${value.text.length}/$maxLength'),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              maxLength: maxLength,
              minLines: minLines,
              maxLines: maxLines,
              buildCounter: (context, {required currentLength, required isFocused, maxLength}) {
                return const Text('');
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: hint,
              ),
            ),
          ],
        );
      },
    );
  }

  void _addBook() {
    final title = _titleController.text.trim();
    final annotation = _annotationController.text.trim();
    final notes = _notesController.text.trim();
    if (title.isNotEmpty && annotation.isNotEmpty) {
      DatabaseService.addBook();//(title: title, annotation: annotation);
      Navigator.of(context).pop(); // Go back to previous page
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, заполните все поля')),
      );
    }
  }

  void _setPicture() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новое произведение'),
        backgroundColor: AppStyles.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 256,
              color: Colors.grey,
            ),
            ElevatedButton(
              onPressed: _setPicture,
              child: const Text('Изменить обложку'),
            ),
            _buildTextFieldWithCounter(
              controller: _titleController,
              label: 'Название',
              hint: 'Название',
              maxLength: 150,
            ),
            _buildTextFieldWithCounter(
              controller: _annotationController,
              label: 'Аннотация',
              hint: 'О чём произведение, кратко.',
              maxLength: 1000,
              minLines: 5,
              maxLines: 15,
            ),
            _buildTextFieldWithCounter(
              controller: _notesController,
              label: 'Примечания',
              hint: 'Ваш комментарий по поводу этой работы, процесса её создания и планов на будущее.',
              maxLength: 1000,
              minLines: 3,
              maxLines: 10,
            ),
            CheckboxListTile(
              title: const Text('Для взрослых (18+)'),
              value: _isAdultContent,
              onChanged: (value) {
                setState(() {
                  _isAdultContent = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _addBook,
              child: const Text('Добавить произведение'),
            ),
          ],
        ),
      ),
    );
  }
}