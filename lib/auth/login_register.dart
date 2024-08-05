import 'package:flutter/material.dart';
import 'package:flutter_newsfeed/screens/login_screen.dart';
import 'package:flutter_newsfeed/screens/register_screen.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});
  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool showLogin = true;

  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginScreen(onTap: toggleScreens);
    } else {
      return RegisterScreen(onTap: toggleScreens);
    }
  }
}
