import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/extensions.dart';

class SimpleLoadingIndicator extends StatelessWidget {
  const SimpleLoadingIndicator({
    this.colours = const [ColorName.chineseBlack],
    this.effect = Indicator.ballPulse,
    this.height,
    this.width,
    super.key,
  });

  final List<Color> colours;
  final Indicator effect;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dx(width ?? 128.0),
      height: context.dy(height ?? 28.0),
      child: LoadingIndicator(indicatorType: effect, colors: colours),
    );
  }
}
