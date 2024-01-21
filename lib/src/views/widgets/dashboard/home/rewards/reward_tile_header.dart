import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';

class RewardTileHeader extends StatelessWidget {
  const RewardTileHeader({
    required this.iconAsset,
    required this.category,
    super.key,
  });

  final SvgGenImage iconAsset;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconAsset.svg(
          height: context.dx(40.0),
          width: context.dx(40.0),
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.dx(10.0),
            vertical: context.dy(4.0),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.dx(8.0)),
            border: const Border.fromBorderSide(
              BorderSide(color: ColorName.warmBlack),
            ),
          ),
          child: Text(
            category,
            style: context.textStyle(
              colour: ColorName.warmBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
