import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:social_network/screens/SignUpScreen.dart';
import '../services/auth_service.dart'; // import AuthService
import '../widgets/CustomTextfield.dart';
import '../widgets/CustomButton.dart';

class Loginscreen extends StatefulWidget {
  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  // Function để gọi API login
  void _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final email = _emailController.text;
    final password = _passwordController.text;
    // Gọi API login
    final result = await AuthService().login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (result['success']) {
      // Lưu token và thông tin người dùng nếu đăng nhập thành công
      String token = result['token'];
      Map<String, dynamic> user = result['user'];
      Get.offAllNamed('/newpost', arguments: {'token': token, 'user': user});
    } else {
      setState(() {
        _errorMessage = result['message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Customtextfield(
              hintText: 'Email',
              controller: _emailController,
              obscureText: false,
              prefixIcon: Icons.email,
            ),
            SizedBox(height: 16),
            Customtextfield(
              hintText: 'Password',
              controller: _passwordController,
              obscureText: true,
              prefixIcon: Icons.lock,
            ),
            SizedBox(height: 24),
            Custombutton(
              text: 'Login',
              onPressd: _login, // Disable button khi đang loading
              color: Colors.black,
              textColor: Colors.white,
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(height: 24),
            TextButton(
              onPressed: () {
                // Sử dụng GetX để chuyển hướng đến màn hình đăng ký
                Get.to(() => Signupscreen());
              },
              child: Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
