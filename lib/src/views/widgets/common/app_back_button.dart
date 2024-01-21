import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/extensions.dart';
import 'svg_button.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({this.onTap, super.key});

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SvgButton(
        onTap: onTap ?? context.pop,
        svgAsset: Assets.graphics.leftChevron,
        height: context.dx(24.0),
        width: context.dx(24.0),
      ),
    );
  }
}
