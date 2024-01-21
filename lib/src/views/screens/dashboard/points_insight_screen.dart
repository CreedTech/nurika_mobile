import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/screen_title_bar.dart';
import '../../widgets/common/space.dart';
import '../../widgets/dashboard/home/insights/points_insight_tile.dart';

class PointsInsightScreen extends ConsumerWidget {
  const PointsInsightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsRecord = ref
        .watch(authViewModel.select((state) => state.currentUser.pointsRecord))
        .toList();

    final userTotalPoints = ref.watch(
      authViewModel.select((state) => state.currentUser.totalPoints),
    );

    final isTodayMissing = pointsRecord.every(
      (data) => DateTime.now().asYyMmDd != '${data["date"]}'.substring(0, 10),
    );

    final localizations = context.l10n;

    if (isTodayMissing) {
      pointsRecord.insert(0, {'date': '${DateTime.now()}'});
    }

    return AnnotatedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.dx(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitleBar(title: localizations.pointsInsight),
              const Space.vertical(24.0),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dx(24.0),
                  vertical: context.dy(18.0),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.dx(8.0)),
                  color: const Color(0xFFFFF4DC),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(localizations.points, style: context.textStyle()),
                        const Space.vertical(6.0),
                        Text(
                          userTotalPoints.formatted,
                          style: context.textStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 32.0,
                          ),
                        ),
                      ],
                    ),
                    Assets.images.starCoin.image(
                      height: context.dx(88.0),
                      width: context.dx(88.0),
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const Space.vertical(40.0),
              Text(
                localizations.pointsOverview,
                style: context.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              const Space.vertical(16.0),
              Expanded(
                child: ListView.separated(
                  physics: bouncingScrollPhysics,
                  itemCount: pointsRecord.length,
                  separatorBuilder: (_, __) => const Space.vertical(40.0),
                  itemBuilder: (_, index) => PointsInsightTile(
                    date: DateTime.parse(pointsRecord[index]['date']),
                    referralReward: pointsRecord[index]['referral'] ?? 0,
                    stepsReward: pointsRecord[index]['step'] ?? 0,
                    quizReward: pointsRecord[index]['quiz'] ?? 0,
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
