import 'package:flutter/material.dart';
import 'action_button_view_model.dart';
import '../../../../resources/shared/colors.dart';
import '../../../../resources/shared/styles.dart';
import 'dart:math';

class ActionButton extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButton._({Key? key, required this.viewModel}) : super(key: key);

  static Widget instantiate({required ActionButtonViewModel viewModel}) {
    return ActionButton._(viewModel: viewModel);
  }

  

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 32;
    double verticalPadding = 12;
    double iconSize = 20;
    TextStyle buttonTextStyle = button3Semibold;

    switch (viewModel.size) {
      case ActionButtonSize.large:
        buttonTextStyle = button1Bold;
        horizontalPadding = 38;
        verticalPadding = 18;
        iconSize = 24;
        break;
      case ActionButtonSize.medium:
        buttonTextStyle = button2Semibold;
        horizontalPadding = 28;
        verticalPadding = 14;
        iconSize = 20;
        break;
      case ActionButtonSize.small:
        buttonTextStyle = button3Semibold;
        horizontalPadding = 16;
        verticalPadding = 8;
        iconSize = 18;
        break;
    }

    // --- cores base estilo do layout ---
    Color backgroundColor = brandPrimary;
    Color textColor = Colors.white;
    Color disabledBackground = brandPrimary.withOpacity(0.4);
    Color disabledText = Colors.white.withOpacity(0.7);

    switch (viewModel.style) {
      case ActionButtonStyle.primary:
        backgroundColor = brandPrimary; // verde principal
        break;
      case ActionButtonStyle.secondary:
        backgroundColor = neutralGrey;
        break;
      case ActionButtonStyle.tertiary:
        backgroundColor = Colors.transparent;
        break;
    }

    final bool enabled = viewModel.isEnabled;

    return Transform(
      transform: Matrix4.skew(-0, 0),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // mais “pill”
          gradient: viewModel.style == ActionButtonStyle.primary && enabled
              ? LinearGradient(
                  colors: [backgroundColor, backgroundColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: viewModel.style == ActionButtonStyle.primary
              ? (enabled ? backgroundColor : disabledBackground)
              : (enabled ? backgroundColor : disabledBackground),
          boxShadow: enabled && viewModel.style == ActionButtonStyle.primary
              ? [
                  BoxShadow(
                    color: backgroundColor.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: enabled ? viewModel.onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            textStyle: buttonTextStyle,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (viewModel.icon != null) ...[
                Transform(
                  transform: Matrix4.skew(0, 0),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 22,
                    height: 22,
                    child: Center(
                      child: Icon(
                        viewModel.icon,
                        size: iconSize,
                        color: enabled ? textColor : disabledText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Transform(
                transform: Matrix4.skew(0, 0),
                alignment: Alignment.center,
                child: Text(
                  viewModel.text, // sem .toUpperCase()
                  style: buttonTextStyle.copyWith(
                    color: enabled ? textColor : disabledText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
