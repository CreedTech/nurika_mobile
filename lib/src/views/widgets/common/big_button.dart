import 'package:flutter/material.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import 'simple_loading_indicator.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    required this.labelText,
    required this.onPressed,
    this.foregroundColour,
    this.backgroundColour,
    this.allBordersColour,
    this.isEnabled = true,
    this.fontSize = 16.0,
    this.isBold = false,
    this.isBusy = false,
    super.key,
  });

  final VoidCallback onPressed;
  final String labelText;

  final Color? foregroundColour;
  final Color? backgroundColour;
  final Color? allBordersColour;

  final double fontSize;

  final bool isEnabled;
  final bool isBold;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isEnabled && !isBusy) ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.dx(8.0)),
          side: BorderSide(
            color: allBordersColour ?? transparent,
            width: context.dx(1.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: context.dy(14.0)),
        backgroundColor: isEnabled
            ? (backgroundColour ?? ColorName.oceanGreen)
            : const Color(0xFFF5F5F5),
        elevation: 0.0,
      ),
      child: Center(
        child: isBusy
            ? SimpleLoadingIndicator(
                colours: [foregroundColour ?? white],
                height: 20.0,
                width: 64.0,
              )
            : Text(
                labelText,
                style: context.textStyle(
                  fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
                  fontSize: fontSize,
                  colour: isEnabled
                      ? (foregroundColour ?? white)
                      : const Color(0xFFBBBBBD),
                ),
              ),
      ),
    );
  }
}
