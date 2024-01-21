import 'package:flutter/material.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../common/clickable.dart';
import '../../../common/space.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    required this.title,
    required this.value,
    this.onTap,
    super.key,
  });

  final GestureTapCallback? onTap;

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final profileTile = Padding(
      padding: EdgeInsets.symmetric(vertical: context.dy(8.0)),
      child: Row(
        children: [
          Text(
            title,
            style: context.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: context.textStyle(
              colour: onTap == null ? ColorName.manatee : ColorName.arsenic,
              fontSize: 18.0,
            ),
          ),
          if (onTap != null) ...[
            const Space.horizontal(8.0),
            Assets.graphics.rightChevron.svg(
              height: context.dx(24.0),
              width: context.dx(24.0),
              fit: BoxFit.cover,
            ),
          ],
        ],
      ),
    );

    return onTap != null
        ? Clickable(onClick: onTap!, child: profileTile)
        : profileTile;
  }
}
