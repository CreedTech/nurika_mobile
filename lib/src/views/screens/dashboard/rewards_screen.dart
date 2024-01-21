import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/dashboard/dashboard_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/raised_container.dart';
import '../../widgets/common/screen_title_bar.dart';
import '../../widgets/common/space.dart';
import '../../widgets/dashboard/home/rewards/reward_progress_bar.dart';
import '../../widgets/dashboard/home/rewards/reward_tile_header.dart';
import 'daily_quiz_intro_screen.dart';
import 'invite_friends_screen.dart';

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDoneDailyQuiz = ref.watch(
      dashboardViewModel.select((state) => state.hasDoneDailyQuiz),
    );

    final localizations = context.l10n;

    return AnnotatedScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Space.vertical(24.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
              child: ScreenTitleBar(title: localizations.dailyRewards),
            ),
            const Space.vertical(24.0),
            RaisedContainer(
              onTap: () => context.pushNamed('$DailyQuizIntroScreen'),
              borderColour: ColorName.brightGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RewardTileHeader(
                    iconAsset: Assets.graphics.messageQuestion,
                    category: localizations.daily,
                  ),
                  const Space.vertical(16.0),
                  Text(
                    localizations.dailyQuiz,
                    style: context.textStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                    ),
                  ),
                  const Space.vertical(8.0),
                  Text(
                    localizations.getPointsEveryday(dailyQuizPoints),
                    style: context.textStyle(
                      colour: ColorName.darkJungleGreen,
                      fontWeight: FontWeight.w300,
                      fontSize: 15.0,
                    ),
                  ),
                  const Space.vertical(16.0),
                  RewardProgressBar(
                    valueNow: hasDoneDailyQuiz ? 1 : 0,
                    maxValue: 1,
                  ),
                ],
              ),
            ),
            const Space.vertical(24.0),
            RaisedContainer(
              onTap: () => context.pushNamed('$InviteFriendsScreen'),
              borderColour: ColorName.brightGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RewardTileHeader(
                    iconAsset: Assets.graphics.twoUsers,
                    category: localizations.ongoing,
                  ),
                  const Space.vertical(16.0),
                  Text(
                    localizations.inviteFriends,
                    style: context.textStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                    ),
                  ),
                  const Space.vertical(8.0),
                  Text(
                    localizations.inviteYourFriends,
                    style: context.textStyle(
                      colour: ColorName.darkJungleGreen,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
