import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../common/clickable.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    required this.iconAsset,
    required this.onTap,
    required this.name,
    this.isOne = false,
    this.trailing,
    this.tint,
    super.key,
  });

  final GestureTapCallback onTap;

  final SvgGenImage iconAsset;

  final Widget? trailing;
  final Color? tint;

  final String name;

  final bool isOne;

  @override
  Widget build(BuildContext context) {
    final settingsTile = Row(
      children: [
        iconAsset.svg(
          height: context.dx(24.0),
          width: context.dx(24.0),
          fit: BoxFit.cover,
        ),
        const Space.horizontal(8.0),
        Text(
          name,
          style: context.textStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20.0,
            colour: tint,
          ),
        ),
        const Spacer(),
        trailing ??
            Assets.graphics.rightChevron.svg(
              height: context.dx(24.0),
              width: context.dx(24.0),
              fit: BoxFit.cover,
            ),
      ],
    );

    return isOne
        ? RaisedContainer(onTap: onTap, child: settingsTile)
        : Clickable(
            onClick: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.dx(16.0),
                vertical: context.dy(8.0),
              ),
              child: settingsTile,
            ),
          );
  }
}
