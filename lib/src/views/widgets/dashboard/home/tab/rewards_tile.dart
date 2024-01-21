import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../screens/dashboard/rewards_screen.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';

class RewardsTile extends StatelessWidget {
  const RewardsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    return RaisedContainer(
      onTap: () => context.pushNamed('$RewardsScreen'),
      padding: EdgeInsets.symmetric(
        horizontal: context.dx(16.0),
        vertical: context.dy(12.0),
      ),
      child: Row(
        children: [
          Assets.graphics.circledBlueCoin.svg(
            height: context.dx(40.0),
            width: context.dx(40.0),
            fit: BoxFit.cover,
          ),
          const Space.horizontal(8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.dailyRewards,
                  style: context.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                const Space.vertical(4.0),
                Text(
                  localizations.claimRewardsNow,
                  style: context.textStyle(
                    colour: ColorName.quartz,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          const Space.horizontal(8.0),
          Assets.graphics.rightChevron.svg(
            height: context.dx(24.0),
            width: context.dx(24.0),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
