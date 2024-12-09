import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_network/widgets/CustomPost.dart';

import '../services/Post_service.dart';
import '../services/User_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PostService postService = PostService();
  final UserService userService = UserService();

  late String token;
  late Map<String, dynamic> user;

  List<Map<String, dynamic>> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Lấy token và thông tin người dùng từ Get.arguments
    final arguments = Get.arguments;
    token = arguments['token'];
    user = arguments['user'];
    // Lấy danh sách bài viết
    //_fetchUserPosts();
  }



  // Future<void> _fetchUserPosts() async {
  //   try {
  //     final result = await postService.getPostsByUser(user['id'], token);
  //     setState(() {
  //       posts = result;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Lỗi tải bài viết: $e')),
  //     );
  //   }
  // }

  void _editProfile() async {
    // Chuyển đến màn hình chỉnh sửa thông tin cá nhân
    final updatedUser = await Get.toNamed('/edit-profile', arguments: {
      'token': token,
      'user': user,
    });

    if (updatedUser != null) {
      setState(() {
        user = updatedUser; // Cập nhật thông tin người dùng sau khi chỉnh sửa
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile, // Chỉnh sửa thông tin cá nhân
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin cá nhân
            Card(
              margin: const EdgeInsets.all(16),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(user['name'][0].toUpperCase()),
                ),
                title: Text(user['name']),
                subtitle: Text(user['email']),
              ),
            ),
            const SizedBox(height: 16),
            // Danh sách bài viết
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                'Bài viết của bạn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Custompost(
                    userName: post['userId']['name'] ?? 'Ẩn danh',
                    userAvatar: post['userId']['avatarImage'] ?? '',
                    content: post['content'] ?? '',
                    imageUrl: post['image'] ?? '',
                    likeCount: (post['likes'] ?? []).length,
                    commentCount: (post['comments'] ?? []).length,
                    postTime: formatTime(post['createdAt']),
                    onLike: () {},
                    onComment: () {},
                    // onTap: () {
                    //   // Chuyển đến chi tiết bài viết
                    // },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  String formatTime(String time) {
    // Chuyển đổi định dạng thời gian, ví dụ: "2024-11-17T15:00:00Z" thành "17/11/2024"
    DateTime dateTime = DateTime.parse(time);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
