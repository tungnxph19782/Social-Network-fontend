import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Xử lý đăng nhập
  void login(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Hiển thị thông báo lỗi nếu thông tin không đầy đủ
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Vui lòng nhập đủ thông tin')));
      return;
    }

    // Gọi API đăng nhập ở đây
    // Ví dụ sử dụng http hoặc dio để gửi yêu cầu đến backend

    // Nếu đăng nhập thành công, điều hướng sang màn hình khác
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
