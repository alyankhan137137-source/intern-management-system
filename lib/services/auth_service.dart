import 'dart:async';
import 'package:intern_management_system/models/user.dart';

class AuthService {
  // Simulated database
  final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': '1',
      'email': 'alyankhan@internee.pk',
      'password': '123456',
      'name': 'Alyan Khan (Intern)',
      'role': UserRole.intern,
    },
    {
      'id': '2',
      'email': 'alyankhan12@gmail.com',
      'password': '123456',
      'name': 'Alyan Khan (Admin)',
      'role': UserRole.admin,
    },
  ];

  Future<UserModel?> login({
    required String email,
    required String password,
    required UserRole role,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    try {
      final userData = _mockUsers.firstWhere(
        (u) => 
          u['email'] == email && 
          u['password'] == password && 
          u['role'] == role,
      );

      return UserModel(
        id: userData['id'],
        email: userData['email'],
        name: userData['name'],
        role: userData['role'],
      );
    } catch (e) {
      return null;
    }
  }
}
