import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/Post_service.dart';
import '../widgets/CustomPost.dart';

class PostListScreen extends StatefulWidget {
  @override
  _PostListScreenState createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late PostService apiService;
  late Future<List<Map<String, dynamic>>> posts;
  late String token;
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    apiService = PostService();
    posts = apiService.getPosts();// Lấy danh sách bài viết
    final arguments = Get.arguments;
    token = arguments['token'];
    user = arguments['user'];
  }
  void _likePost(String postId) async {
    print('User ID: ${user['id']}');
    print('Token: $token');
    print(postId);
    try {
      await apiService.likePost(postId, user['id'], token);
      setState(() {
        posts = [] as Future<List<Map<String, dynamic>>>;
      });
      try {
        final newPosts = await apiService.getPosts();
        setState(() {
          posts = newPosts as Future<List<Map<String, dynamic>>>;
        });
      } catch (e) {
        print('Error loading posts: $e');
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi thích bài viết: $e + dbdbbdbdb')),
      );
      print('loi khi like: $e');
    }
  }
  void _addComment(String postId) {
    TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thêm bình luận'),
        content: TextField(
          controller: commentController,
          decoration: InputDecoration(hintText: 'Nhập bình luận...'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                await apiService.addComment(postId, user['id'], commentController.text, token);
                setState(() {
                  posts = apiService.getPosts();
                });
                Navigator.of(context).pop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi khi thêm bình luận: $e')),
                );
              }
            },
            child: Text('Gửi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Sách Bài Viết'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Có lỗi xảy ra!'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Không có bài viết nào.'));
          }

          final postList = snapshot.data!;
          return ListView.builder(
            itemCount: postList.length,
            itemBuilder: (context, index) {
              final post = postList[index];
              return Custompost(
                userName: post['userId']['name'] ?? 'Ẩn danh',
                userAvatar: post['userId']['avatarImage'] ?? '',
                content: post['content'] ?? '',
                imageUrl: post['image'] ?? '',
                likeCount: (post['likes'] ?? []).length,
                commentCount: (post['comments'] ?? []).length,
                postTime: formatTime(post['createdAt']),
                onLike: () => _likePost(post['_id']),
                onComment: () => _addComment(post['_id']),
                // onTap: () {
                //   // Chuyển đến chi tiết bài viết
                // },
              );
            },
          );
        },
      ),
    );
  }

  String formatTime(String time) {
    // Chuyển đổi định dạng thời gian, ví dụ: "2024-11-17T15:00:00Z" thành "17/11/2024"
    DateTime dateTime = DateTime.parse(time);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
