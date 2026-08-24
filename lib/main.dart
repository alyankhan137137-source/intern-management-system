import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/views/splash_screen.dart';

void main() {
  runApp(const InternManagementApp());
}

class InternManagementApp extends StatelessWidget {
  const InternManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intern Management System',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
