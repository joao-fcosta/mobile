import '../../resources/shared/app_coordinator.dart';

class HomeViewModel {
  final AppCoordinator coordinator;

  HomeViewModel({
    required AppCoordinator coordinator,
  }) : coordinator = coordinator;

  void presentHome(){
    coordinator.goToLogin();
  }

}