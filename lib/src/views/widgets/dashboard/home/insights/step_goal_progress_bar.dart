import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../../../viewmodels/dashboard/dashboard_view_model.dart';

class StepGoalProgressBar extends ConsumerWidget {
  const StepGoalProgressBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyStepsTarget = ref.watch(
      authViewModel.select((state) => state.currentUser.dailyStepsTarget),
    );

    final stepCountToday = ref.watch(
      dashboardViewModel.select((state) => state.stepCountToday),
    );

    return Row(
      children: [
        Expanded(
          child: LinearPercentIndicator(
            percent: (stepCountToday / dailyStepsTarget).clamp(0.0, 1.0),
            padding: EdgeInsets.only(right: context.dx(16.0)),
            barRadius: Radius.circular(context.dx(64.0)),
            backgroundColor: const Color(0xFFF0F0F0),
            progressColor: const Color(0xFFFFA51E),
            animateFromLastPercent: true,
            lineHeight: context.dy(16.0),
            animation: true,
          ),
        ),
        Text(
          '${stepCountToday.formatted}/${dailyStepsTarget.formatted}',
          style: context.textStyle(
            colour: ColorName.manatee,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
