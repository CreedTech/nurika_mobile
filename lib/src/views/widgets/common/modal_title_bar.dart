import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/extensions.dart';
import 'space.dart';
import 'svg_button.dart';

class ModalTitleBar extends StatelessWidget {
  const ModalTitleBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Space.horizontal(44.0),
        Text(
          title,
          style: context.textStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
        ),
        SvgButton(
          svgAsset: Assets.graphics.xClose,
          height: context.dx(44.0),
          width: context.dx(44.0),
          onTap: context.pop,
        ),
      ],
    );
  }
}
