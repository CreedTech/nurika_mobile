import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../../viewmodels/dashboard/dashboard_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/clickable.dart';
import '../../widgets/common/screen_title_bar.dart';
import '../../widgets/common/space.dart';
import '../../widgets/dashboard/home/insights/set_step_goal_modal.dart';
import '../../widgets/dashboard/home/insights/step_goal_progress_bar.dart';
import '../../widgets/dashboard/home/insights/steps_insight_tile.dart';

class StepsInsightScreen extends ConsumerWidget {
  const StepsInsightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepCountRecord = ref
        .watch(authViewModel.select((state) => state.currentUser.stepsRecord))
        .toList();

    final dailyStepsTarget = ref.watch(
      authViewModel.select((state) => state.currentUser.dailyStepsTarget),
    );

    final stepCountToday = ref.watch(
      dashboardViewModel.select((state) => state.stepCountToday),
    );

    final isTodayMissing = stepCountRecord.every(
      (data) => DateTime.now().asYyMmDd != '${data["date"]}'.substring(0, 10),
    );

    final stepsFromGoal = dailyStepsTarget - stepCountToday;

    final localizations = context.l10n;

    final goalStatus = stepsFromGoal < 0
        ? localizations.stepsBeyondYourGoal
        : localizations.stepsFromYourGoal;

    if (isTodayMissing) {
      stepCountRecord.insert(0, {'date': '${DateTime.now()}'});
    }

    return AnnotatedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.dx(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitleBar(title: localizations.stepsInsight),
              const Space.vertical(24.0),
              Container(
                padding: EdgeInsets.all(context.dx(16.0)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.dx(8.0)),
                  color: ColorName.warmBlack,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.steps,
                              style: context.textStyle(colour: white),
                            ),
                            const Space.vertical(6.0),
                            Text(
                              stepCountToday.formatted,
                              style: context.textStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 32.0,
                                colour: white,
                              ),
                            ),
                          ],
                        ),
                        Assets.images.blueHill.image(
                          height: context.dx(52.0),
                          width: context.dx(52.0),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    const Space.vertical(14.0),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.dx(16.0),
                        vertical: context.dy(12.0),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.dx(8.0)),
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    localizations.dailyStepsGoal,
                                    style: context.textStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Space.vertical(4.0),
                                  Text(
                                    '${stepsFromGoal.abs().formatted} $goalStatus',
                                    style: context.textStyle(
                                      colour: ColorName.quartz,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                              Clickable(
                                onClick: () => showDialog(
                                  builder: (_) => const SetStepGoalModal(),
                                  useRootNavigator: true,
                                  context: context,
                                ),
                                child: Assets.graphics.pencil.svg(
                                  height: context.dx(32.0),
                                  width: context.dx(32.0),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          const Space.vertical(12.0),
                          const StepGoalProgressBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Space.vertical(40.0),
              Text(
                localizations.stepsOverview,
                style: context.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              const Space.vertical(16.0),
              Expanded(
                child: ListView.separated(
                  physics: bouncingScrollPhysics,
                  itemCount: stepCountRecord.length,
                  separatorBuilder: (_, __) => const Space.vertical(16.0),
                  itemBuilder: (_, index) => StepsInsightTile(
                    date: DateTime.parse(stepCountRecord[index]['date']),
                    steps: stepCountRecord[index]['count'] ?? 0,
                  ),
                ),
              ),
              const Space.vertical(24.0),
            ],
          ),
        ),
      ),
    );
  }
}
