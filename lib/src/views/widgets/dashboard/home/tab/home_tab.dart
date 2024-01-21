import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../common/space.dart';
import 'hello_header.dart';
import 'points_tile.dart';
import 'progress_panel.dart';
import 'referrals_pane.dart';
import 'rewards_tile.dart';
import 'step_goal_tile.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  static const _sections = [
    HelloHeader(),
    ProgressPanel(),
    StepGoalTile(),
    PointsTile(),
    RewardsTile(),
    ReferralsPane(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      physics: bouncingScrollPhysics,
      padding: EdgeInsets.symmetric(vertical: context.dy(24.0)),
      separatorBuilder: (_, __) => const Space.vertical(24.0),
      itemBuilder: (_, index) => _sections[index],
      itemCount: _sections.length,
    );
  }
}
