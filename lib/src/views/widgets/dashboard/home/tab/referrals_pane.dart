import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';

class ReferralsPane extends ConsumerWidget {
  const ReferralsPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPoints = ref.watch(
      authViewModel.select((state) => state.currentUser.totalPoints),
    );

    final referralId = ref.watch(
      authViewModel.select((state) => state.currentUser.referralId),
    );

    final localizations = context.l10n;

    return RaisedContainer(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.referrals,
            style: context.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
          ),
          const Space.vertical(4.0),
          Text(
            localizations.inviteYourFriends,
            style: context.textStyle(
              fontWeight: FontWeight.w300,
              colour: ColorName.quartz,
            ),
          ),
          const Space.vertical(16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  style: context.textStyle(fontSize: 24.0),
                  children: [
                    TextSpan(
                      text: '${totalPoints.formatted} ',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      style: const TextStyle(fontSize: 16.0),
                      text: totalPoints != 1
                          ? localizations.points
                          : localizations.point,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () => Share.share(
                  localizations.joinMillionsOfStars(invitationUrl, referralId),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.dx(8.0)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.dx(10.0),
                    vertical: context.dy(8.0),
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
        ],
      ),
    );
  }
}
