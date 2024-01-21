import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/dashboard/dashboard_view_model.dart';

class StepsInsightTile extends ConsumerWidget {
  const StepsInsightTile({required this.date, required this.steps, super.key});

  final DateTime date;
  final int steps;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stepCountToday = ref.watch(
      dashboardViewModel.select((state) => state.stepCountToday),
    );

    final stepCount =
        DateTime.now().asYyMmDd == date.asYyMmDd ? stepCountToday : steps;

    final localizations = context.l10n;

    return Container(
      padding: EdgeInsets.symmetric(vertical: context.dy(12.0)),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ColorName.brightGrey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateTime.now().asYyMmDd != date.asYyMmDd
                ? DateFormat('MMMM d, y').format(date)
                : localizations.today,
            style: context.textStyle(fontWeight: FontWeight.w300),
          ),
          RichText(
            text: TextSpan(
              style: context.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              children: [
                TextSpan(text: '${stepCount.formatted} '),
                TextSpan(
                  text:
                      stepCount == 1 ? localizations.step : localizations.steps,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
