import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/space.dart';

class InviteFriendsScreen extends ConsumerWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final referralId = ref.watch(
      authViewModel.select((state) => state.currentUser.referralId),
    );

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
              Text(
                localizations.inviteFriends,
                style: context.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0,
                ),
              ),
              const Space.vertical(8.0),
              Text(
                localizations.inviteYourFriends,
                style: context.textStyle(
                  colour: ColorName.darkJungleGreen,
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                ),
              ),
              const Spacer(),
              Center(
                child: Assets.graphics.circledGift.svg(
                  height: context.dx(64.0),
                  width: context.dx(64.0),
                  fit: BoxFit.cover,
                ),
              ),
              const Space.vertical(32.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.dx(16.0)),
                child: Text(
                  localizations.unlockHealthAndWealth,
                  textAlign: TextAlign.center,
                  style: context.textStyle(
                    colour: ColorName.arsenic,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const Space.vertical(8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.dx(16.0)),
                child: Text(
                  localizations.weBelieveInRewarding,
                  textAlign: TextAlign.center,
                  style: context.textStyle(
                    colour: ColorName.arsenic,
                    fontSize: 16.5,
                  ),
                ),
              ),
              const Spacer(),
              BigButton(
                labelText: localizations.invite,
                onPressed: () => Share.share(
                  localizations.joinMillionsOfStars(invitationUrl, referralId),
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
