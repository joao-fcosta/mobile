import 'package:flutter/cupertino.dart';
import '../../resources/shared/app_coordinator.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = HomeViewModel(coordinator: coordinator);
    return HomeView(viewModel: viewModel);
  }

} 