import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import 'clickable.dart';

class SvgButton extends StatelessWidget {
  const SvgButton({
    required this.svgAsset,
    required this.onTap,
    this.height,
    this.width,
    this.tint,
    super.key,
  });

  final GestureTapCallback onTap;

  final SvgGenImage svgAsset;

  final double? height;
  final double? width;

  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return Clickable(
      onClick: onTap,
      child: svgAsset.svg(
        fit: BoxFit.cover,
        colorFilter:
            tint != null ? ColorFilter.mode(tint!, BlendMode.srcIn) : null,
        height: height,
        width: width,
      ),
    );
  }
}
