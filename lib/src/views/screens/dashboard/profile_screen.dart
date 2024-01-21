import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/raised_container.dart';
import '../../widgets/common/screen_title_bar.dart';
import '../../widgets/common/space.dart';
import '../../widgets/common/user_avatar_circle.dart';
import '../../widgets/dashboard/settings/profile/age_bottom_sheet.dart';
import '../../widgets/dashboard/settings/profile/edit_height_modal.dart';
import '../../widgets/dashboard/settings/profile/edit_weight_modal.dart';
import '../../widgets/dashboard/settings/profile/gender_bottom_sheet.dart';
import '../../widgets/dashboard/settings/profile/picture_picker_bottom_sheet.dart';
import '../../widgets/dashboard/settings/profile/profile_tile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isProcessing = ref.watch(
      authViewModel.select((state) => state.isProcessing),
    );

    final bodyHeight = ref.watch(
      authViewModel.select((state) => state.currentUser.bodyHeight),
    );

    final bodyWeight = ref.watch(
      authViewModel.select((state) => state.currentUser.bodyWeight),
    );

    final heightUnit = ref.watch(
      authViewModel.select((state) => state.currentUser.heightUnit),
    );

    final weightUnit = ref.watch(
      authViewModel.select((state) => state.currentUser.weightUnit),
    );

    final fullName = ref.watch(
      authViewModel.select((state) => state.currentUser.fullName),
    );

    final gender = ref.watch(
      authViewModel.select((state) => state.currentUser.gender),
    );

    final email = ref.watch(
      authViewModel.select((state) => state.currentUser.email),
    );

    final age = ref.watch(
      authViewModel.select((state) => state.currentUser.age),
    );

    final localizations = context.l10n;

    return AnnotatedScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          padding: EdgeInsets.all(context.dx(24.0)),
          child: Column(
            children: [
              ScreenTitleBar(title: localizations.profile),
              const Space.vertical(40.0),
              const UserAvatarCircle(size: 80.0),
              const Space.vertical(8.0),
              ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.dx(20.0)),
                    ),
                  ),
                  builder: (_) => const PicturePickerBottomSheet(),
                  backgroundColor: white,
                  context: context,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(context.dx(8.0)),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: context.dx(12.0),
                    vertical: context.dy(8.0),
                  ),
                  backgroundColor: ColorName.oceanGreen,
                  elevation: 0.0,
                ),
                child: Text(
                  localizations.changeProfileImage,
                  style: context.textStyle(colour: white),
                ),
              ),
              const Space.vertical(40.0),
              RaisedContainer(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dx(16.0),
                  vertical: context.dy(8.0),
                ),
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    ProfileTile(title: localizations.name, value: fullName),
                    const Space.vertical(16.0),
                    ProfileTile(title: localizations.email, value: email),
                    const Space.vertical(16.0),
                    ProfileTile(
                      value: gender,
                      title: localizations.gender,
                      onTap: () => showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(context.dx(20.0)),
                          ),
                        ),
                        builder: (_) => const GenderBottomSheet(),
                        backgroundColor: white,
                        context: context,
                      ),
                    ),
                    const Space.vertical(16.0),
                    ProfileTile(
                      value: bodyHeight > 0.0
                          ? '${bodyHeight.formatted} $heightUnit'
                          : '',
                      title: localizations.height,
                      onTap: () => showDialog(
                        builder: (_) => const EditHeightModal(),
                        useRootNavigator: true,
                        context: context,
                      ),
                    ),
                    const Space.vertical(16.0),
                    ProfileTile(
                      title: localizations.weight,
                      value: bodyWeight > 0.0
                          ? '${bodyWeight.formatted} $weightUnit'
                          : '',
                      onTap: () => showDialog(
                        builder: (_) => const EditWeightModal(),
                        useRootNavigator: true,
                        context: context,
                      ),
                    ),
                    const Space.vertical(16.0),
                    ProfileTile(
                      title: localizations.age,
                      value: age > 0 ? '$age' : '',
                      onTap: () => showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(context.dx(20.0)),
                          ),
                        ),
                        builder: (_) => const AgeBottomSheet(),
                        backgroundColor: white,
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
              const Space.vertical(176.0),
              BigButton(
                isBusy: isProcessing,
                labelText: localizations.saveChanges,
                onPressed: () {
                  ref
                      .read(authViewModel.notifier)
                      .saveProfileChanges()
                      .then((didSucceed) {
                    Fluttertoast.showToast(
                      msg: didSucceed
                          ? localizations.savedSuccessfully
                          : localizations.unableToSaveChanges,
                    );
                  });
                },
              ),
              const Space.vertical(24.0),
            ],
          ),
        ),
      ),
    );
  }
}
