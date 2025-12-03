import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../resources/shared/app_coordinator.dart';

void main() {
  final coordinator = AppCoordinator();
  runApp(Application(coordinator: coordinator));
}

class Application extends StatelessWidget {
  final AppCoordinator coordinator;
  const Application({super.key, required this.coordinator});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "ContaLitro",
        navigatorKey: coordinator.navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: coordinator.startApp());
  }
}


