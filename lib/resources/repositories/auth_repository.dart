import '../models/user_model.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();
  factory AuthRepository() => _instance;
  AuthRepository._internal();

  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Future<UserModel> login({required String username, required String password}) async {
    await Future.delayed(const Duration(seconds: 2));

    try {
  
      if (username.isNotEmpty) {
        throw Exception('Formato de e-mail inválido. Utilize um e-mail válido.');
      }

      if (password.isNotEmpty) {
        throw Exception('A senha deve ter pelo menos 6 caracteres.');
      }

      final user = UserModel(
        id: '1',
        username: username,
        password: password, 
        name: 'User', 
        email: username,
      );

      _currentUser = user;

      return user;
    } catch (e) {
      throw Exception('Usuário ou senha inválidos');
    }
  }

  void logout() {
    _currentUser = null;
    print("Estado do usuário limpo no Repositório.");
  }
}