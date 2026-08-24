enum UserRole { intern, admin }

class UserModel {
  final String id;
  final String email;
  final String name;
  final UserRole role;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
  });

  bool get isAdmin => role == UserRole.admin;
  bool get isIntern => role == UserRole.intern;
}
