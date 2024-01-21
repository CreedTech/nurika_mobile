import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../../screens/dashboard/change_password_screen.dart';
import '../../../../screens/dashboard/language_screen.dart';
import '../../../../screens/dashboard/profile_screen.dart';
import '../../../../screens/init/onboarding_screen.dart';
import '../../../common/space.dart';
import 'delete_account_modal.dart';
import 'settings_tile.dart';
import 'settings_tile_group.dart';
import 'user_info_header.dart';

class SettingsTab extends ConsumerStatefulWidget {
  const SettingsTab({super.key});

  @override
  ConsumerState<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends ConsumerState<SettingsTab> {
  late final _localizations = context.l10n;

  @override
  void initState() {
    super.initState();
    FlutterBackgroundService().on('signOut').listen((_) {
      ref.read(authViewModel.notifier).signOut();
      _exitDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: bouncingScrollPhysics,
      padding: EdgeInsets.symmetric(vertical: context.dy(24.0)),
      child: Column(
        children: [
          const UserInfoHeader(),
          const Space.vertical(24.0),
          SettingsTile(
            name: _localizations.personalData,
            iconAsset: Assets.graphics.personalCard,
            onTap: () => context.pushNamed('$ProfileScreen'),
            isOne: true,
          ),
          const Space.vertical(16.0),
          SettingsTileGroup(
            name: _localizations.settings,
            onTapTile: (index) => context.pushNamed(
              ['$ChangePasswordScreen', '$LanguageScreen'][index],
            ),
            tileIconAssets: [Assets.graphics.lock, Assets.graphics.language],
            tileNames: [
              _localizations.passwordSettings,
              _localizations.language,
            ],
          ),
          const Space.vertical(16.0),
          SettingsTileGroup(
            name: _localizations.contactUs,
            onTapTile: (index) => launchUrl(
              Uri.parse(
                [
                  termsOfServiceLink,
                  privacyPolicyLink,
                  feedUsBackLink,
                  helpCenterLink,
                ][index],
              ),
              mode: LaunchMode.externalApplication,
            ),
            tileIconAssets: [
              Assets.graphics.shieldCheck,
              Assets.graphics.policyNotes,
              Assets.graphics.feedback,
              Assets.graphics.message,
            ],
            tileNames: [
              _localizations.termsOfService,
              _localizations.privacyPolicy,
              _localizations.feedback,
              _localizations.faqs,
            ],
          ),
          const Space.vertical(16.0),
          SettingsTileGroup(
            name: _localizations.socialMedia,
            onTapTile: (index) => launchUrl(
              Uri.parse(socialLinks[index]),
              mode: LaunchMode.externalApplication,
            ),
            tileIconAssets: [
              Assets.graphics.x,
              Assets.graphics.facebook,
              Assets.graphics.telegram,
              Assets.graphics.youtube,
              Assets.graphics.medium,
              Assets.graphics.linkedin,
              Assets.graphics.instagram,
            ],
            tileNames: const [
              'X (formerly Twitter)',
              'Facebook',
              'Telegram',
              'YouTube',
              'Medium',
              'LinkedIn',
              'Instagram',
            ],
          ),
          const Space.vertical(16.0),
          SettingsTile(
            tint: ColorName.cadmiumRed,
            name: _localizations.deleteAccount,
            iconAsset: Assets.graphics.closeCircle,
            trailing: const SizedBox.shrink(),
            onTap: () => showDialog(
              builder: (context) =>
                  DeleteAccountModal(onDeleteAccount: _exitDashboard),
              useRootNavigator: true,
              context: context,
            ),
            isOne: true,
          ),
          const Space.vertical(16.0),
          SettingsTile(
            name: _localizations.logOut,
            tint: ColorName.cadmiumRed,
            trailing: const SizedBox.shrink(),
            iconAsset: Assets.graphics.logOut,
            onTap: () => showDialog(
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.dx(16.0)),
                ),
                content: Text(
                  _localizations.areYouSureToLogOut,
                  style: context.textStyle(fontSize: 18.0),
                ),
                actions: [
                  TextButton(
                    onPressed: context.pop,
                    child: Text(
                      _localizations.cancel,
                      style: context.textStyle(fontSize: 18.0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(authViewModel.notifier).signOut();
                      _exitDashboard();
                    },
                    child: Text(
                      _localizations.logOut,
                      style: context.textStyle(fontSize: 18.0, colour: red),
                    ),
                  ),
                ],
              ),
              useRootNavigator: true,
              context: context,
            ),
            isOne: true,
          ),
        ],
      ),
    );
  }

  void _exitDashboard() => context.goNamed('$OnboardingScreen');
}
