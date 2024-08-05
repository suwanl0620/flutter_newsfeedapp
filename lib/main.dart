import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_newsfeed/auth/auth.dart';
import 'package:flutter_newsfeed/auth/login_register.dart';
import 'package:flutter_newsfeed/screens/home_screen.dart';
import 'package:flutter_newsfeed/screens/profile_screen.dart';
import 'package:flutter_newsfeed/screens/users_screen.dart';
import 'package:flutter_newsfeed/firebase_options.dart';
import 'package:flutter_newsfeed/theme/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AuthScreen(),
        theme: lightMode,
        routes: {
          '/login_register': (context) => const LoginRegister(),
          '/home_screen': (context) => HomeScreen(),
          '/profile_screen': (context) => ProfileScreen(),
          '/users_screen': (context) => const UsersScreen(),
        });
  }
}
