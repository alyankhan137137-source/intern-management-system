import 'package:flutter/material.dart';
import 'package:intern_management_system/models/user.dart';
import 'package:intern_management_system/views/intern/intern_main_view.dart';
import 'package:intern_management_system/views/admin/admin_main_view.dart';
import 'package:intern_management_system/views/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Enterprise Routing Logic
    if (user.role == UserRole.intern) {
      return InternMainView(user: user);
    }

    if (user.role == UserRole.admin) {
      return AdminMainView(user: user);
    }

    // Default Fallback
    return const WelcomeScreen();
  }
}
