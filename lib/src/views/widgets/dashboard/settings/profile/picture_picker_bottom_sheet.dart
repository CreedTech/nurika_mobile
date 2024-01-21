import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/clickable.dart';
import '../../../common/space.dart';

class PicturePickerBottomSheet extends ConsumerWidget {
  const PicturePickerBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localizations = context.l10n;

    Future<void> pickImage(int sourceIndex) async {
      final auth = ref.read(authViewModel.notifier);

      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.values[sourceIndex],
        imageQuality: 80,
      );

      auth.update(
        base64Dp: pickedImage != null
            ? base64Encode(await pickedImage.readAsBytes())
            : '',
      );
    }

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: context.dy(16.0)),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorName.brightGrey)),
            ),
            alignment: Alignment.center,
            child: Text(
              localizations.changeProfileImage,
              style: context.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          const Space.vertical(32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Clickable(
                onClick: () => pickImage(0).then((_) => context.pop()),
                child: Column(
                  children: [
                    Assets.graphics.circledCam.svg(
                      height: context.dx(40.0),
                      width: context.dx(40.0),
                      fit: BoxFit.cover,
                    ),
                    const Space.vertical(8.0),
                    Text(
                      localizations.camera,
                      style: context.textStyle(colour: ColorName.quartz),
                    ),
                  ],
                ),
              ),
              const Space.horizontal(156.0),
              Clickable(
                onClick: () => pickImage(1).then((_) => context.pop()),
                child: Column(
                  children: [
                    Assets.graphics.circledPic.svg(
                      height: context.dx(40.0),
                      width: context.dx(40.0),
                      fit: BoxFit.cover,
                    ),
                    const Space.vertical(8.0),
                    Text(
                      localizations.gallery,
                      style: context.textStyle(colour: ColorName.quartz),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Space.vertical(24.0),
        ],
      ),
    );
  }
}
