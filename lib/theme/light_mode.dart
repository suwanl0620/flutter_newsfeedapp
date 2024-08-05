import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.orange.shade100,
        primary: Colors.orange.shade200,
        secondary: Colors.orange.shade300,
        inversePrimary: Colors.orange.shade800,
    ),
    textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.brown[700], // Darker shade for readability
        displayColor: Colors.brown[700], // Darker shade for readability
    ),
);