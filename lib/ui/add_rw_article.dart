import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_flutter/data/model/article.dart';

class AddRwArticle extends StatefulWidget {
  const AddRwArticle({super.key});

  @override
  State<AddRwArticle> createState() => _AddRwArticleState();
}

class _AddRwArticleState extends State<AddRwArticle> {
  DateTime? selectedDateTime;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _creController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController(); // Ô nhập đường dẫn ảnh

  // Hàm để hiển thị Date và Time Picker
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  // Định dạng ngày và giờ
  String getFormattedDateTime() {
    return selectedDateTime == null
        ? 'No date and time chosen'
        : DateFormat("EEE, d MMM, yyyy").format(selectedDateTime!);
  }

  // Hàm lưu bài viết vào ObjectBox
  void _saveArticle() {
    if (_imageUrlController.text.isEmpty || _titleController.text.isEmpty || selectedDateTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final article = Article(
      date: selectedDateTime,
      title: _titleController.text,
      cre: _creController.text,
      imageUrl: _imageUrlController.text, // Lưu đường dẫn ảnh do người dùng nhập
    );

    // Thêm logic lưu vào ObjectBox ở đây
    // articleBox.put(article);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Article saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Article", style: TextStyle(fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(_titleController, 'Article Title'),
            _buildTextField(_creController, 'Article Content'),
            const SizedBox(height: 16),
            Text('Date and Time: ${getFormattedDateTime()}', style: const TextStyle(fontSize: 16)),
            _buildButton('Select Date & Time', () => _selectDateTime(context)),
            const SizedBox(height: 16),
            // Ô nhập đường dẫn ảnh
            _buildTextField(_imageUrlController, 'Enter Image URL or Path'),
            const SizedBox(height: 16),
            // Hiển thị ảnh đã chọn từ đường dẫn do người dùng nhập
            _imageUrlController.text.isNotEmpty
                ? _imageUrlController.text.startsWith('http')
                    ? Image.network(
                        _imageUrlController.text, // Hiển thị ảnh từ URL
                        height: 150,
                      )
                    : Image.file(
                        File(_imageUrlController.text), // Hiển thị ảnh từ đường dẫn tệp cục bộ
                        height: 150,
                      )
                : const Text('No image selected'),
            const SizedBox(height: 16),
            _buildButton('Save Article', _saveArticle),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black38),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
