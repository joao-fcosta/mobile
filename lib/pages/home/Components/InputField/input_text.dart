import 'package:flutter/material.dart';
import 'input_text_view_model.dart';
import '../Buttons/ActionButton/action_button.dart';
import '../Buttons/ActionButton/action_button_view_model.dart' as abvm;

// Assumindo que ActionButton.skewFactor é acessível.

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

  // Importe o fator de inclinação (skew) do ActionButton para consistência.
  final double _skewFactor = ActionButton.skewFactor; 

  @override
  void initState() {
    super.initState();
    obscureText = widget.viewModel.password;
    widget.viewModel.controller.addListener(validateInput);
  }

  void validateInput() {
    final errorText = widget.viewModel.validator?.call(widget.viewModel.controller.text);
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
    Widget? suffix;
    
    // =========================================================
    // 1. Lógica para ícones que não são o ActionButton de limpar
    // =========================================================
    if (widget.viewModel.password) {
      // Ícone de visibilidade de senha
      suffix = Transform(
        transform: Matrix4.skew(_skewFactor, 0), 
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: togglePasswordVisibility,
        ),
      );
    } else if (widget.viewModel.suffixIcon != null) {
      // Ícone sufixo fornecido pelo usuário
      suffix = Transform(
        transform: Matrix4.skew(_skewFactor, 0),
        alignment: Alignment.center,
        child: widget.viewModel.suffixIcon,
      );
    } else {
      // =========================================================
      // 2. Lógica Unificada para ActionButton (Customizado ou de Limpar)
      // =========================================================
      suffix = ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.viewModel.controller,
        builder: (_, value, __) {
          final hasText = value.text.isNotEmpty;
          
          // Determina se devemos mostrar o ActionButton (seja ele customizado ou o de limpar)
          final bool isCustomButton = widget.viewModel.actionButtonViewModel != null;
          final bool shouldShowButton = isCustomButton 
                                      ? widget.viewModel.showActionButton 
                                      : hasText; // Botão de limpar só aparece se tiver texto

          if (!shouldShowButton || !widget.viewModel.isEnabled) {
            return const SizedBox(width: 0, height: 0);
          }

          // Define o ViewModel base
          abvm.ActionButtonViewModel baseViewModel;
          
          if (isCustomButton) {
            // Usa o ViewModel fornecido (botão customizado)
            baseViewModel = widget.viewModel.actionButtonViewModel!;
          } else {
            // Cria um ViewModel Padrão de 'Limpar'
            baseViewModel = abvm.ActionButtonViewModel(
              size: abvm.ActionButtonSize.small,
              style: abvm.ActionButtonStyle.tertiary, 
              text: '', 
              icon: Icons.close, 
              onPressed: (){}, 
            );
          }

          // Cria uma cópia com a ação de limpeza envolvida, que é priorizada
          final wrapped = abvm.ActionButtonViewModel(
            size: baseViewModel.size,
            style: baseViewModel.style,
            text: baseViewModel.text,
            icon: baseViewModel.icon,
            onPressed: () {
              // Ação de limpar é executada se houver texto
              if (hasText) {
                  widget.viewModel.controller.clear();
                  validateInput();
              }
              // Chamada à ação original APENAS se o botão for customizado
              if (isCustomButton) {
                   baseViewModel.onPressed?.call();
              }
            },
          );

          return Padding(
            padding: const EdgeInsets.only(right: 4),
            // Envolve o ActionButton no Transform oposto para endireitar
            child: Transform(
              transform: Matrix4.skew(_skewFactor, 0),
              alignment: Alignment.center,
              child: ActionButton.instantiate(viewModel: wrapped),
            ),
          );
        },
      );
    }

    // =========================================================
    // 3. Aplica o Decoration e o Transform no campo
    // =========================================================
    InputDecoration decoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      filled: true,
      suffixIcon: suffix,
      fillColor: widget.viewModel.isEnabled ? Colors.white : Colors.grey.shade400,
      labelText: widget.viewModel.placeholder.isNotEmpty ? widget.viewModel.placeholder : null,
      labelStyle: const TextStyle(color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.black, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      errorText: errorMsg,
    );

    // Inclina o campo de input inteiro
    return Transform(
      transform: Matrix4.skew(-_skewFactor, 0), // Inclinação negativa no eixo X
      alignment: Alignment.center,
      child: TextFormField(
        controller: widget.viewModel.controller,
        obscureText: obscureText,
        decoration: decoration,
        style: const TextStyle(color: Colors.black), 
        enabled: widget.viewModel.isEnabled,
      ),
    );
  }
}