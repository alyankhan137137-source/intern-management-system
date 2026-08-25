import 'package:flutter/material.dart';
import 'package:intern_management_system/models/user.dart';
import 'package:intern_management_system/views/intern/intern_main_view.dart';
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

    // Admin Placeholder
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('Admin Dashboard - Coming Soon'),
      ),
    );
  }
}
