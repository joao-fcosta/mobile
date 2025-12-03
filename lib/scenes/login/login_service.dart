import '/resources/repositories/auth_repository.dart';

class LoginService {
  final AuthRepository repository;

  LoginService({required this.repository});

  Future <void> fetchLogin({required String user, required String password}) async {
    await repository.login(username: user, password: password);
  }

}
