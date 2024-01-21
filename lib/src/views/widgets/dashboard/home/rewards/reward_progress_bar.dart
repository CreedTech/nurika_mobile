import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';

class RewardProgressBar extends StatelessWidget {
  const RewardProgressBar({
    required this.valueNow,
    required this.maxValue,
    super.key,
  });

  final int valueNow;
  final int maxValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        LinearPercentIndicator(
          padding: EdgeInsets.zero,
          percent: (valueNow / maxValue).clamp(0.0, 1.0),
          barRadius: Radius.circular(context.dx(64.0)),
          backgroundColor: const Color(0xFFF0F0F0),
          progressColor: const Color(0xFFFFA51E),
          animateFromLastPercent: true,
          lineHeight: context.dy(16.0),
          animation: true,
        ),
        Text(
          '$valueNow/$maxValue',
          style: context.textStyle(
            colour: ColorName.manatee,
            fontWeight: FontWeight.w600,
            fontSize: 10.0,
          ),
        ),
      ],
    );
  }
}
