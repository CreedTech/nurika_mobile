import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../models/team/referral_team_member.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/space.dart';
import '../../widgets/dashboard/leaderboard/team/referral_team_member_tile.dart';

class ReferralTeamScreen extends ConsumerWidget {
  const ReferralTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referralId = ref.watch(
      authViewModel.select((state) => state.currentUser.referralId),
    );

    final referralTeam = ref.watch(
      authViewModel.select((state) => state.currentUser.referrals),
    );

    final totalReferralPoints = referralTeam.length * 10;

    final localizations = context.l10n;

    return AnnotatedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.dx(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackButton(),
              const Space.vertical(24.0),
              Container(
                padding: EdgeInsets.all(context.dx(16.0)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.dx(8.0)),
                  color: const Color.fromRGBO(202, 218, 254, 0.30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations.totalReferralPoints,
                          style: context.textStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '$totalReferralPoints ${localizations.points}',
                          style: context.textStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => Share.share(
                        localizations.joinMillionsOfStars(
                          invitationUrl,
                          referralId,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(context.dx(8.0)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.dx(28.0),
                          vertical: context.dy(4.0),
                        ),
                        backgroundColor: ColorName.oceanGreen,
                        elevation: 0.0,
                      ),
                      child: Text(
                        localizations.invite,
                        style: context.textStyle(
                          fontWeight: FontWeight.w500,
                          colour: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Space.vertical(24.0),
              Text(
                localizations.referralTeam,
                style: context.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ),
              ),
              const Space.vertical(8.0),
              Text(
                '${localizations.theNumberOfMembers} ${referralTeam.length}',
                style: context.textStyle(
                  colour: ColorName.darkJungleGreen,
                  fontWeight: FontWeight.w300,
                  fontSize: 13.0,
                ),
              ),
              const Space.vertical(24.0),
              Expanded(
                child: ListView.separated(
                  physics: bouncingScrollPhysics,
                  itemCount: referralTeam.length,
                  separatorBuilder: (_, __) => const Space.vertical(16.0),
                  itemBuilder: (_, index) => ReferralTeamMemberTile(
                    member: ReferralTeamMember.fromJson(referralTeam[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
