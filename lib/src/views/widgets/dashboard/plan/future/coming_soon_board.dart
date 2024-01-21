import 'package:flutter/material.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';

class ComingSoonBoard extends StatelessWidget {
  const ComingSoonBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.dy(12.0)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.dx(8.0)),
        color: const Color(0xFFF5F5F5),
      ),
      child: Text(
        context.l10n.comingSoon,
        style: context.textStyle(
          colour: ColorName.warmBlack,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
