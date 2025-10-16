import 'package:flutter/material.dart';
import 'action_button_view_model.dart';
import '../../../shared/colors.dart';
import '../../../shared/styles.dart';
import 'dart:math';

class ActionButton extends StatelessWidget {
  final ActionButtonViewModel viewModel;

  const ActionButton._({Key? key, required this.viewModel}) : super(key: key);

  static Widget instantiate({required ActionButtonViewModel viewModel}) {
    return ActionButton._(viewModel: viewModel);
  }

  static double skewFactor = tan(5 * pi / 180);

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = 32;
    double verticalPadding = 12;
    double iconSize = 24;
    TextStyle buttonTextStyle = button3Semibold;
    Color buttonColor = lightPrimaryBrandColor;
    
    Color gradientStartColor = darkPrimaryBrandColor; 
    Color gradientEndColor = normalPrimaryBrandColor;  
    Color borderColor = darkPrimaryBaseColorLight;
    
    switch (viewModel.size) {
      case ActionButtonSize.large:
        buttonTextStyle = button1Bold;
        horizontalPadding = 38;
        verticalPadding = 18;
        iconSize = 24;
        break;
      case ActionButtonSize.medium:
        buttonTextStyle = button2Semibold;
        horizontalPadding = 24;
        verticalPadding = 10;
        iconSize = 20;
        break;
      case ActionButtonSize.small:
        buttonTextStyle = button3Semibold;
        horizontalPadding = 16;
        verticalPadding = 8;
        iconSize = 16;
        break;
    }

    switch (viewModel.style) {
      case ActionButtonStyle.primary:
        buttonColor = normalPrimaryBrandColor;
        gradientStartColor = normalPrimaryBrandColor;
        gradientEndColor = darkPrimaryBrandColor;
        borderColor = darkPrimaryBaseColorLight;
        break;
      case ActionButtonStyle.secondary:
        buttonColor = normalSecondaryBrandColor;
        gradientStartColor = normalSecondaryBrandColor;
        gradientEndColor = darkSecondaryBrandColor;
        borderColor = darkPrimaryBaseColorLight;
        break;
      case ActionButtonStyle.tertiary:
        buttonColor = normalErrorSystemColor;
        gradientStartColor = normalErrorSystemColor;
        gradientEndColor = darkErrorSystemColor;
        borderColor = darkPrimaryBaseColorLight;
        break;
    }

    final bool enabled = viewModel.isEnabled;
    final Color disabledBackground = darkSecondaryBaseColorDark;
    final Color disabledText = lightSecondaryBaseColorDark;

    return Transform(
      transform: Matrix4.skew(-skewFactor, 0),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: enabled
              ? LinearGradient(
                  colors: [gradientStartColor, gradientEndColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: enabled ? null : disabledBackground,
          border: Border.all(color: borderColor, width: 2),
          boxShadow: enabled
              ? [
                  BoxShadow(
                    color: darkPrimaryBaseColorLight.withOpacity(0.4),
                    blurRadius: 4,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            textStyle: buttonTextStyle,
            padding: EdgeInsets.symmetric(
              vertical: verticalPadding,
              horizontal: horizontalPadding,
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (viewModel.icon != null) ...[
                Transform(
                  transform: Matrix4.skew(skewFactor, 0),
                  alignment: Alignment.center,
                  child: Container(
                    width: 26,
                    height: 26,
                    child: Center(
                      child: Icon(
                        viewModel.icon,
                        size: iconSize,
                        color: enabled ? Colors.white : disabledText,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Transform(
                transform: Matrix4.skew(skewFactor, 0),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Text(
                      viewModel.text.toUpperCase(),
                      style: buttonTextStyle.copyWith(
                        fontSize: buttonTextStyle.fontSize,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 3
                          ..color = darkPrimaryBaseColorLight,
                      ),
                    ),
                    Text(
                      viewModel.text.toUpperCase(),
                      style: buttonTextStyle.copyWith(
                          color: enabled ? Colors.white : disabledText),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}