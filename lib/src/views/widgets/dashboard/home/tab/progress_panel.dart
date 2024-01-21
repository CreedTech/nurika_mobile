import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../../../viewmodels/dashboard/dashboard_view_model.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';

class ProgressPanel extends ConsumerWidget {
  const ProgressPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyStepsTarget = ref.watch(
      authViewModel.select((state) => state.currentUser.dailyStepsTarget),
    );

    final stepCountToday = ref.watch(
      dashboardViewModel.select((state) => state.stepCountToday),
    );

    // final moveMin = stepCountToday * minutesPerStep;
    // final kms = stepCountToday * kilometersPerStep;
    // final cal = stepCountToday * caloriesPerStep;

    final localizations = context.l10n;

    return RaisedContainer(
      child: Column(
        children: [
          Text(
            localizations.today,
            style: context.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
          const Space.vertical(28.0),
          CircularPercentIndicator(
            percent: (stepCountToday / dailyStepsTarget).clamp(0.0, 1.0),
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: const Color(0xFFF2F4F7),
            progressColor: ColorName.oceanGreen,
            animateFromLastPercent: true,
            lineWidth: context.dx(8.0),
            radius: context.dx(84.0),
            center: Container(
              width: context.dx(148.0),
              height: context.dx(148.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.graphics.footprints.svg(
                    height: context.dx(24.0),
                    width: context.dx(24.0),
                    fit: BoxFit.cover,
                  ),
                  const Space.vertical(4.0),
                  Text(
                    stepCountToday.formatted,
                    textAlign: TextAlign.center,
                    style: context.textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 36.0,
                    ),
                  ),
                  const Space.vertical(4.0),
                  Text(
                    stepCountToday == 1
                        ? localizations.step
                        : localizations.steps,
                    style: context.textStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            animation: true,
          ),
          const Space.vertical(28.0),
          /* SizedBox(
            height: context.dy(56.0),
            child: ListView.separated(
              physics: unscrollableScrollPhysics,
              itemBuilder: (context, index) => Column(
                children: [
                  Text(
                    [
                      cal > 0.0 ? cal.toStringAsFixed(1) : '0',
                      moveMin > 0.0 ? moveMin.round().formatted : '0',
                      kms > 0.0 ? kms.toStringAsFixed(3) : '0',
                    ][index],
                    style: context.textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                  const Space.vertical(4.0),
                  Text(
                    [
                      localizations.cal,
                      localizations.moveMin,
                      localizations.km,
                    ][index],
                    style: context.textStyle(
                      colour: ColorName.quartz,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              separatorBuilder: (_, __) => const Space.horizontal(42.0),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 3,
            ),
          ), */
        ],
      ),
    );
  }
}
