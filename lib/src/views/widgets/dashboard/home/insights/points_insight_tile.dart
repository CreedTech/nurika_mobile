import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../common/space.dart';

class PointsInsightTile extends StatelessWidget {
  const PointsInsightTile({
    required this.referralReward,
    required this.stepsReward,
    required this.quizReward,
    required this.date,
    super.key,
  });

  final int referralReward;
  final int stepsReward;
  final int quizReward;

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    final rewardValues = [quizReward, stepsReward, referralReward];

    final rewardTypes = [
      localizations.quizReward,
      localizations.stepsReward,
      localizations.referralReward,
    ];

    final iconAssets = [
      Assets.graphics.amberCircledQuestionMessage,
      Assets.graphics.circledSteps,
      Assets.graphics.circledUser,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateTime.now().asYyMmDd != date.asYyMmDd
              ? DateFormat('MMMM d, y').format(date)
              : localizations.today,
          style: context.textStyle(colour: ColorName.quartz),
        ),
        const Space.vertical(16.0),
        for (final (index, type) in rewardTypes.indexed)
          Container(
            padding: EdgeInsets.symmetric(vertical: context.dy(12.0)),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.brightGrey)),
            ),
            child: Row(
              children: [
                iconAssets[index].svg(
                  height: context.dx(40.0),
                  width: context.dx(40.0),
                  fit: BoxFit.cover,
                ),
                const Space.horizontal(8.0),
                Text(
                  type,
                  style: context.textStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const Spacer(),
                Text(
                  '${rewardValues[index].formatted} '
                  '${rewardValues[index] != 1 ? localizations.points : localizations.point}',
                ),
              ],
            ),
          ),
      ],
    );
  }
}
