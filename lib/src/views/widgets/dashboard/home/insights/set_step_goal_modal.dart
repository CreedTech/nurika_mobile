import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../services/interfaces/storage_service.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/big_button.dart';
import '../../../common/modal_title_bar.dart';
import '../../../common/space.dart';
import 'step_goal_change_button.dart';

class SetStepGoalModal extends ConsumerStatefulWidget {
  const SetStepGoalModal({super.key});

  @override
  ConsumerState<SetStepGoalModal> createState() => _SetStepsGoalModalState();
}

class _SetStepsGoalModalState extends ConsumerState<SetStepGoalModal> {
  late final _localizations = context.l10n;

  late var _stepsTarget = ref.read(authViewModel).currentUser.dailyStepsTarget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.dx(16.0)),
      ),
      contentPadding: EdgeInsets.all(context.dx(16.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModalTitleBar(title: _localizations.setDailyStepsGoal),
          const Space.vertical(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StepGoalChangeButton(
                iconAsset: Assets.graphics.minus,
                onPressed: () {
                  if (_stepsTarget > minimumDailyStepsTarget) {
                    setState(() => _stepsTarget -= dailyStepsTargetIncrement);
                  }
                },
              ),
              Text(
                _stepsTarget.formatted,
                style: context.textStyle(
                  colour: ColorName.lavenderGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 48.0,
                ),
              ),
              StepGoalChangeButton(
                iconAsset: Assets.graphics.plus,
                onPressed: () {
                  if (_stepsTarget < maximumDailyStepsTarget) {
                    setState(() => _stepsTarget += dailyStepsTargetIncrement);
                  }
                },
              ),
            ],
          ),
          const Space.vertical(40.0),
          BigButton(labelText: _localizations.save, onPressed: _onSave),
        ],
      ),
    );
  }

  void _onSave() {
    context.pop();

    final updatedUser = ref
        .read(authViewModel)
        .currentUser
        .copyWith(dailyStepsTarget: _stepsTarget);

    ref.read(authViewModel.notifier).update(currentUser: updatedUser);

    FlutterBackgroundService().invoke('subtlyUpdateUser', {
      accessTokenKey: storage.getString(accessTokenKey),
      currentUserKey: updatedUser,
    });
  }
}
