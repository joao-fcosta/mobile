import '../../resources/shared/app_coordinator.dart';
import 'login_service.dart';

class LoginViewModel {
  final LoginService service;
  final AppCoordinator coordinator;

  LoginViewModel({
    required LoginService service,
    required AppCoordinator coordinator,
  }) : service = service, coordinator = coordinator;


  Future<void> performLogin({
    required String user,
    required String password,
    required void Function() onSuccess, }) async {
    await service.fetchLogin(user: user, password: password);
    onSuccess();
  }

  void presentHome(){
    coordinator.goToHome();
  }

}