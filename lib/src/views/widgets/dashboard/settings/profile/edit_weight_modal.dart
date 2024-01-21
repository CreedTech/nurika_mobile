import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../services/interfaces/storage_service.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/big_button.dart';
import '../../../common/clickable.dart';
import '../../../common/modal_title_bar.dart';
import '../../../common/space.dart';

class EditWeightModal extends ConsumerStatefulWidget {
  const EditWeightModal({super.key});

  @override
  ConsumerState<EditWeightModal> createState() => _EditWeightModalState();
}

class _EditWeightModalState extends ConsumerState<EditWeightModal> {
  late final _localizations = context.l10n;

  late var _bodyWeight = ref.read(authViewModel).currentUser.bodyWeight;
  late var _weightUnit = ref.read(authViewModel).currentUser.weightUnit;

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
          ModalTitleBar(title: _localizations.weight),
          const Space.vertical(24.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final unit in weightUnits)
                Clickable(
                  onClick: () => setState(() => _weightUnit = unit),
                  child: Container(
                    decoration: BoxDecoration(
                      color: unit == _weightUnit ? ColorName.lightSilver : null,
                      border: const Border.fromBorderSide(
                        BorderSide(color: ColorName.lavenderGrey),
                      ),
                      borderRadius: BorderRadius.horizontal(
                        left: unit == weightUnits.first
                            ? Radius.circular(context.dx(32.0))
                            : Radius.zero,
                        right: unit == weightUnits.last
                            ? Radius.circular(context.dx(32.0))
                            : Radius.zero,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.dx(16.0),
                      vertical: context.dy(10.0),
                    ),
                    child: Text(
                      unit,
                      style: context.textStyle(
                        colour: ColorName.darkJungleGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Space.vertical(16.0),
          TextFormField(
            onChanged: (value) => setState(() {
              _bodyWeight = int.tryParse(value) ?? _bodyWeight;
            }),
            initialValue: '$_bodyWeight',
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            textAlign: TextAlign.center,
            style: context.textStyle(
              colour: ColorName.lavenderGrey,
              fontWeight: FontWeight.w600,
              fontSize: 48.0,
            ),
          ),
          const Space.vertical(24.0),
          BigButton(labelText: _localizations.save, onPressed: _onSave),
        ],
      ),
    );
  }

  void _onSave() {
    context.pop();

    final updatedUser = ref.read(authViewModel).currentUser.copyWith(
          bodyWeight: _bodyWeight,
          weightUnit: _weightUnit,
        );

    ref.read(authViewModel.notifier).update(currentUser: updatedUser);

    FlutterBackgroundService().invoke('subtlyUpdateUser', {
      accessTokenKey: storage.getString(accessTokenKey),
      currentUserKey: updatedUser,
    });
  }
}
