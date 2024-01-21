import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../../screens/dashboard/steps_insight_screen.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';
import '../insights/step_goal_progress_bar.dart';

class StepGoalTile extends ConsumerWidget {
  const StepGoalTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = context.l10n;

    return RaisedContainer(
      onTap: () {
        ref.read(authViewModel.notifier).fetchCurrentUserData();
        context.pushNamed('$StepsInsightScreen');
      },
      child: Row(
        children: [
          Assets.graphics.flagCircle.svg(
            height: context.dx(40.0),
            width: context.dx(40.0),
            fit: BoxFit.cover,
          ),
          const Space.horizontal(12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.dailyStepsGoal,
                  style: context.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                const Space.vertical(4.0),
                Text(
                  localizations.reachYourDailyGoal,
                  style: context.textStyle(
                    colour: ColorName.quartz,
                    fontSize: 16.0,
                  ),
                ),
                const Space.vertical(12.0),
                const StepGoalProgressBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
