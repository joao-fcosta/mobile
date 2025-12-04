import 'package:flutter/material.dart';
import '../Buttons/ActionButton/action_button_view_model.dart';

class InputTextViewModel {
  final TextEditingController controller;

  /// Texto em cima do campo: "Email", "Senha"...
  final String label;

  /// Texto dentro do campo: "seu@email.com"
  final String? hintText;

  bool password;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isEnabled;
  final String? Function(String?)? validator;
  final VoidCallback? togglePasswordVisibility;
  final ActionButtonViewModel? actionButtonViewModel;
  final bool showActionButton;
  final bool enableClearButton;

  InputTextViewModel({
    required this.controller,
    required this.label,
    this.hintText,
    this.password = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnabled = true,
    this.validator,
    this.togglePasswordVisibility,
    this.actionButtonViewModel,
    this.showActionButton = false,
    this.enableClearButton = true,
  });
}
