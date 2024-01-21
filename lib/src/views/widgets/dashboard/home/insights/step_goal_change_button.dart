import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../common/hyper_clickable.dart';

class StepGoalChangeButton extends StatelessWidget {
  const StepGoalChangeButton({
    required this.iconAsset,
    required this.onPressed,
    super.key,
  });

  final GestureTapCallback onPressed;
  final SvgGenImage iconAsset;

  @override
  Widget build(BuildContext context) {
    return HyperClickable(
      onClick: onPressed,
      child: SizedBox(
        width: context.dx(36.0),
        height: context.dx(36.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: ColorName.lightSilver),
              borderRadius: BorderRadius.circular(context.dx(8.0)),
            ),
            padding: EdgeInsets.zero,
            backgroundColor: white,
            elevation: 0.0,
          ),
          child: iconAsset.svg(
            height: context.dx(20.0),
            width: context.dx(20.0),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
