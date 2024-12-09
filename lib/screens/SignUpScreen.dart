import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../widgets/CustomTextfield.dart';
import '../widgets/CustomButton.dart';
import '../services/auth_service.dart'; // Import AuthService của bạn để gọi API

class Signupscreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Signupscreen({super.key});

  // Function để gọi API đăng ký
  void _signUp() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final phone = _phoneController.text;
    final confirmPassword = _confirmPasswordController.text;
    final avata = '';
    final bio = '';

    // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp không
    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Gọi API đăng ký
    final result = await AuthService().signup(name,email, password,phone,avata,bio);

    if (result['success']) {
      // Nếu đăng ký thành công, chuyển hướng tới màn hình đăng nhập
      Get.offAllNamed('/login');
    } else {
      // Nếu có lỗi, hiển thị thông báo lỗi
      Get.snackbar('Error', result['message'], snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Customtextfield(
              hintText: 'Name',
              controller: _nameController,
              obscureText: false,
              prefixIcon: Icons.person,
            ),
            SizedBox(height: 16),
            Customtextfield(
              hintText: 'Email',
              controller: _emailController,
              obscureText: false,
              prefixIcon: Icons.email,
            ),
            SizedBox(height: 16),
            Customtextfield(
              hintText: 'Phone',
              controller: _phoneController,
              obscureText: false,
              prefixIcon: Icons.phone,
            ),
            SizedBox(height: 16),
            Customtextfield(
              hintText: 'Password',
              controller: _passwordController,
              obscureText: true,
              prefixIcon: Icons.lock,
            ),
            SizedBox(height: 16),
            Customtextfield(
              hintText: 'Confirm Password',
              controller: _confirmPasswordController,
              obscureText: true,
              prefixIcon: Icons.lock,
            ),
            SizedBox(height: 24),
            Custombutton(
              text: 'Sign Up',
              onPressd: _signUp,
              color: Colors.black,
              textColor: Colors.white,
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Chuyển hướng đến màn hình đăng nhập khi đã có tài khoản
                Get.toNamed('/login');
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
