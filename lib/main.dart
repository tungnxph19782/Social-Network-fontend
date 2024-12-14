import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_network/screens/AddPostScreen.dart';
import 'package:social_network/screens/HomeScreen.dart';
import 'package:social_network/screens/LoginScreen.dart';
import 'package:social_network/screens/NewScreen.dart';
import 'package:social_network/screens/ProfileScreen.dart';
import 'package:social_network/screens/SignUpScreen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      initialRoute: '/login', // Màn hình khởi đầu là màn hình đăng nhập
      getPages: [
        GetPage(name: '/login', page: () => Loginscreen()),
        GetPage(name: '/home', page: () => HomeScreen()), // Đảm bảo khai báo các route ở đây
        GetPage(name: '/signup', page: () => Signupscreen()),
        GetPage(name: '/newpost', page: () => PostListScreen()),
        GetPage(name: '/addpost', page: () => AddPostScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
      ],
    );
  }
}
