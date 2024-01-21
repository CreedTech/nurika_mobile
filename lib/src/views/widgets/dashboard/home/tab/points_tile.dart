import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../../screens/dashboard/points_insight_screen.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';

class PointsTile extends ConsumerWidget {
  const PointsTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPoints = ref.watch(
      authViewModel.select((state) => state.currentUser.totalPoints),
    );

    return RaisedContainer(
      onTap: () {
        ref.read(authViewModel.notifier).fetchCurrentUserData();
        context.pushNamed('$PointsInsightScreen');
      },
      padding: EdgeInsets.symmetric(
        horizontal: context.dx(16.0),
        vertical: context.dy(12.0),
      ),
      child: Row(
        children: [
          Assets.graphics.circledCrown.svg(
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
                  totalPoints.formatted,
                  style: context.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                const Space.vertical(4.0),
                Text(
                  context.l10n.pointsEarned,
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
