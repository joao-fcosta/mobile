import 'package:flutter/material.dart';
import 'input_text_view_model.dart';
import '../Buttons/ActionButton/action_button.dart';
import '../Buttons/ActionButton/action_button_view_model.dart' as abvm;

class StyledInputField extends StatefulWidget {
  final InputTextViewModel viewModel;

  const StyledInputField._({Key? key, required this.viewModel}) : super(key: key);

  @override
  StyledInputFieldState createState() => StyledInputFieldState();

  static Widget instantiate({required InputTextViewModel viewModel}) {
    return StyledInputField._(viewModel: viewModel);
  }
}

class StyledInputFieldState extends State<StyledInputField> {
  late bool obscureText;
  String? errorMsg;


  @override
  void initState() {
    super.initState();
    obscureText = widget.viewModel.password;
    widget.viewModel.controller.addListener(validateInput);
  }

  void validateInput() {
    final errorText =
        widget.viewModel.validator?.call(widget.viewModel.controller.text);
    setState(() {
      errorMsg = errorText;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void dispose() {
    widget.viewModel.controller.removeListener(validateInput);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ======================
    // SUFFIX (olho / limpar)
    // ======================
    Widget? suffix;
    if (widget.viewModel.password) {
      suffix = Transform(
        transform: Matrix4.skew(0, 0),
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 18,
            color: Colors.white.withOpacity(0.8),
          ),
          onPressed: togglePasswordVisibility,
        ),
      );
    } else if (widget.viewModel.suffixIcon != null) {
      suffix = Transform(
        transform: Matrix4.skew(0, 0),
        alignment: Alignment.center,
        child: widget.viewModel.suffixIcon,
      );
    } else if (widget.viewModel.enableClearButton) {
      // Botão de limpar / custom
      suffix = ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.viewModel.controller,
        builder: (_, value, __) {
          final hasText = value.text.isNotEmpty;

          final bool isCustomButton =
              widget.viewModel.actionButtonViewModel != null;
          final bool shouldShowButton =
              isCustomButton ? widget.viewModel.showActionButton : hasText;

          if (!shouldShowButton || !widget.viewModel.isEnabled) {
            return const SizedBox.shrink();
          }

          abvm.ActionButtonViewModel baseViewModel;

          if (isCustomButton) {
            baseViewModel = widget.viewModel.actionButtonViewModel!;
          } else {
            baseViewModel = abvm.ActionButtonViewModel(
              size: abvm.ActionButtonSize.small,
              style: abvm.ActionButtonStyle.tertiary,
              text: '',
              icon: Icons.close,
              onPressed: () {},
            );
          }

          final wrapped = abvm.ActionButtonViewModel(
            size: baseViewModel.size,
            style: baseViewModel.style,
            text: baseViewModel.text,
            icon: baseViewModel.icon,
            onPressed: () {
              if (hasText) {
                widget.viewModel.controller.clear();
                validateInput();
              }
              if (isCustomButton) {
                baseViewModel.onPressed?.call();
              }
            },
          );

          return Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Transform(
              transform: Matrix4.skew(0, 0),
              alignment: Alignment.center,
              child: ActionButton.instantiate(viewModel: wrapped),
            ),
          );
        },
      );
    } else {
      suffix = null;
    }

    // ======================
    // PREFIX (ícone à esquerda)
    // ======================
    Widget? prefix;
    if (widget.viewModel.prefixIcon != null) {
      prefix = Transform(
        transform: Matrix4.skew(0, 0),
        alignment: Alignment.center,
        child: widget.viewModel.prefixIcon,
      );
    }

    // Cores mais próximas do layout
    const fieldRadius = 10.0;
    final enabledBorderColor = Colors.white.withOpacity(0.25);
    const focusedBorderColor = Color(0xFF22C5A8); // verde/azul neon

    final decoration = InputDecoration(
      hintText: widget.viewModel.hintText,
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(0.35),
        fontSize: 13,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      filled: true,
      fillColor: widget.viewModel.isEnabled
          ? const Color(0xFF020617).withOpacity(0.85) // fundo escuro
          : const Color(0xFF1E293B).withOpacity(0.5),
      prefixIcon: prefix,
      prefixIconConstraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
      suffixIcon: suffix,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 40,
        minHeight: 40,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: BorderSide(color: enabledBorderColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: BorderSide(color: enabledBorderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: const BorderSide(color: focusedBorderColor, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: const BorderSide(color: Colors.red, width: 1.4),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(fieldRadius),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.15),
          width: 1,
        ),
      ),
      errorText: errorMsg,
    );

    // Coluna: label em cima + campo
    return Transform(
      transform: Matrix4.skew(-0, 0),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.viewModel.label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: widget.viewModel.controller,
            obscureText: obscureText,
            decoration: decoration,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            cursorColor: focusedBorderColor,
            enabled: widget.viewModel.isEnabled,
          ),
        ],
      ),
    );
  }
}
