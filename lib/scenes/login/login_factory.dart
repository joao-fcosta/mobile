import 'package:flutter/cupertino.dart';
import '/resources/repositories/auth_repository.dart';
import '../../resources/shared/app_coordinator.dart';
import 'login_service.dart';
import 'login_view.dart';
import 'login_view_model.dart';

class LoginFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final repository = AuthRepository();
    final service = LoginService(repository: repository);
    final viewModel = LoginViewModel(service: service, coordinator: coordinator);
    return LoginView(viewModel: viewModel);
  }

} 