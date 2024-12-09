import 'dart:convert';
import 'package:http/http.dart' as http;

class PostService {
  // Địa chỉ URL của API
  static const String baseUrl = 'http://localhost:2003/api/post';

  // Hàm tạo bài viết mới
  Future<Map<String, dynamic>> createPost(String content, String image, String token) async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
      body: json.encode({
        'content': content,
        'image': image,
      }),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body); // Trả về kết quả bài viết đã được tạo
    } else {
      throw Exception('Failed to create post');
    }
  }

  // Hàm lấy danh sách bài viết
  Future<List<Map<String, dynamic>>> getPosts() async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List posts = json.decode(response.body);
      return posts.map((post) => post as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // // Hàm lấy chi tiết bài viết
  // Future<Map<String, dynamic>> getPostDetails(String postId) async {
  //   final url = Uri.parse('$baseUrl/posts/$postId');
  //   final response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body); // Trả về thông tin chi tiết bài viết
  //   } else {
  //     throw Exception('Failed to load post details');
  //   }
  // }

  // Hàm cập nhật bài viết
  // Future<Map<String, dynamic>> updatePost(String postId, String content, String image, String token) async {
  //   final url = Uri.parse('$baseUrl/posts/$postId');
  //   final response = await http.put(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token', // Thêm token vào header
  //     },
  //     body: json.encode({
  //       'content': content,
  //       'image': image,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body); // Trả về bài viết đã được cập nhật
  //   } else {
  //     throw Exception('Failed to update post');
  //   }
  // }
  //
  // // Hàm xóa bài viết
  // Future<void> deletePost(String postId, String token) async {
  //   final url = Uri.parse('$baseUrl/posts/$postId');
  //   final response = await http.delete(
  //     url,
  //     headers: {
  //       'Authorization': 'Bearer $token', // Thêm token vào header
  //     },
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to delete post');
  //   }
  // }
  //
  //
  // Future<List<Map<String, dynamic>>> getPostsByUser(String userId, String token) async {
  //   final url = Uri.parse('$baseUrl/posts/user/$userId');
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {'Authorization': 'Bearer $token'},
  //     );
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     if (response.statusCode == 200) {
  //       final List posts = json.decode(response.body);
  //       return posts.map((post) => post as Map<String, dynamic>).toList();
  //     } else {
  //       throw Exception('Failed to load posts: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error fetching posts: $e');
  //   }
  // }

  Future<void> likePost(String postId, String userId, String token) async {
    final url = Uri.parse('$baseUrl/posts/$postId/like');
    print('Request URL: $url'); // Log URL được sử dụng
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
      body: json.encode({'userId': userId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to like the post');
    }
  }

  Future<void> addComment(String postId, String userId, String content, String token) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comment');
    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer $token'},
      body: json.encode({'userId': userId, 'content': content}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add a comment');
    }
  }
}
