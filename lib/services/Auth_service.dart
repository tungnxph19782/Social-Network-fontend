import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:2003/api/auth';

  // Đăng ký người dùng
  Future<Map<String, dynamic>> signup(String name, String email, String password, String phone, String avatarImage, String bio) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'avatarImage': avatarImage,
        'bio': bio
      }),
    );

    if (response.statusCode == 201) {
      return {'success': true, 'message': 'Đăng ký thành công'};
    } else {
      return {'success': false, 'message': json.decode(response.body)['message']};
    }
  }

  // Đăng nhập người dùng
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'success': true,
        'token': data['token'],
        'user': data['user'],
      };
    } else {
      return {
        'success': false,
        'message': json.decode(response.body)['message'],
      };
    }
  }

  // Lấy thông tin người dùng
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {
        'success': true,
        'user': data,
      };
    } else {
      return {
        'success': false,
        'message': json.decode(response.body)['message'],
      };
    }
  }
}
