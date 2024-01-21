import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/extensions.dart';

class PasswordStrengthBar extends StatelessWidget {
  const PasswordStrengthBar({required this.password, super.key});

  final String password;

  @override
  Widget build(BuildContext context) {
    const fractions = [0.25, 0.50, 0.75, 1.00];

    const tintColours = [
      Color(0xFFF6370D),
      Color(0xFFF6A70D),
      Color(0xFF42A4FF),
      Color(0xFF05D31A),
    ];

    final strengthIndex = password.isValidPassword
        ? password.length >= 12
            ? 3
            : password.length >= 10
                ? 2
                : 1
        : 0;

    final localizations = context.l10n;

    final adjectives = [
      localizations.weak,
      localizations.fair,
      localizations.good,
      localizations.strong,
    ];

    return Row(
      children: [
        Expanded(
          child: LinearPercentIndicator(
            percent: fractions[strengthIndex],
            padding: EdgeInsets.only(right: context.dx(12.0)),
            barRadius: Radius.circular(context.dx(4.0)),
            progressColor: tintColours[strengthIndex],
            backgroundColor: ColorName.brightGrey,
            animateFromLastPercent: true,
            lineHeight: context.dy(8.0),
            animation: true,
          ),
        ),
        Text(
          adjectives[strengthIndex],
          style: context.textStyle(
            colour: ColorName.darkJungleGreen,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
