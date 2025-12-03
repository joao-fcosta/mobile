class UserModel {
  final String id;
  final String username;
  final String password;
  final String name;
  final String email;
  final String avatarUrl = '';

  UserModel({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
  });
}