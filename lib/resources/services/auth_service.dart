import '../repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _repository;

  AuthService({required AuthRepository repository}) : _repository = repository;

  Future<void> login({required String user, required String password}) async {
    await _repository.login(username: user, password: password);
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));

    _repository.logout();

    print("Usuário deslogado com sucesso e estado limpo.");
  }
}