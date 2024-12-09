import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserService {
  static const String baseUrl = 'http://localhost:2003/api/auth';

  // // Cập nhật thông tin người dùng
  // Future<Map<String, dynamic>> updateUser(String userId, String name, String email, String token) async {
  //   final url = Uri.parse('$baseUrl/$userId');
  //   final response = await http.put(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //     body: json.encode({'name': name, 'email': email}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('Failed to update user');
  //   }
  // }
}
