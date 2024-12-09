import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_network/screens/NewScreen.dart';

import '../services/Post_service.dart';


class AddPostScreen extends StatefulWidget {
  // late final String token; // Token xác thực
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController contentController = TextEditingController();
  String? _imagePath;
  late PostService apiService = PostService();
  late String token;  // Khai báo token
  late Map<String, dynamic> user;  // Khai báo user

  @override
  void initState() {
    super.initState();

    // Lấy arguments từ Get
    var arguments = Get.arguments;
    token = arguments['token'];  // Gán token
    user = arguments['user'];    // Gán user
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Lưu đường dẫn ảnh
      });
    }
  }

  void removeImage() {
    setState(() {
      _imagePath = null; // Xóa ảnh đã chọn
    });
  }

  void savePost() async {
    final content = contentController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập nội dung bài viết!')),
      );
      return;
    }

    try {
      final newPost = await apiService.createPost(
        content,
        _imagePath ?? '', // Truyền đường dẫn ảnh hoặc chuỗi rỗng
        token,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bài viết đã được thêm thành công!')),
      );

      Get.to(() => PostListScreen()); // Quay lại màn hình trước đó
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: ${e.toString()}')),
      );
    }
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Thêm bài viết mới'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: contentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Nội dung',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (_imagePath != null)
                  Stack(
                    children: [
                      Image.file(
                        File(_imagePath!),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: IconButton(
                          onPressed: removeImage,
                          icon: const Icon(Icons.cancel, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                if (_imagePath == null)
                  ElevatedButton.icon(
                    onPressed: pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text('Thêm ảnh'),
                  ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: savePost,
                  child: const Text('Lưu bài viết'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }



