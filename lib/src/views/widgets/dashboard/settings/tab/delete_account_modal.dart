import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/big_button.dart';
import '../../../common/space.dart';

class DeleteAccountModal extends ConsumerWidget {
  const DeleteAccountModal({required this.onDeleteAccount, super.key});

  final VoidCallback onDeleteAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isProcessing = ref.watch(
      authViewModel.select((state) => state.isProcessing),
    );

    final localizations = context.l10n;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.dx(16.0)),
      ),
      contentPadding: EdgeInsets.all(context.dx(16.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.graphics.circledBin.svg(
            height: context.dx(48.0),
            width: context.dx(48.0),
            fit: BoxFit.cover,
          ),
          const Space.vertical(24.0),
          Text(
            localizations.yourAccountWillBe,
            textAlign: TextAlign.center,
            style: context.textStyle(
              colour: ColorName.independence,
              fontSize: 16.0,
            ),
          ),
          const Space.vertical(24.0),
          BigButton(
            isBold: true,
            isBusy: isProcessing,
            backgroundColour: ColorName.vermilion,
            labelText: localizations.yesDeleteMyAccount,
            onPressed: () => ref
                .read(authViewModel.notifier)
                .deleteAccount()
                .then((didDelete) {
              if (didDelete) {
                onDeleteAccount();
              }
            }),
          ),
          const Space.vertical(12.0),
          BigButton(
            isBold: true,
            labelText: localizations.cancel,
            allBordersColour: ColorName.lightSilver,
            foregroundColour: ColorName.charcoal,
            backgroundColour: white,
            onPressed: context.pop,
          ),
        ],
      ),
    );
  }
}
