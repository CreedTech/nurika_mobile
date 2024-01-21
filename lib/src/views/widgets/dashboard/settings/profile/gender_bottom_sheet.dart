import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/clickable.dart';
import '../../../common/space.dart';

class GenderBottomSheet extends ConsumerWidget {
  const GenderBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gender = ref.watch(
      authViewModel.select((state) => state.currentUser.gender),
    );

    final localizations = context.l10n;

    final genderOptions = localizations.allGenderOptions.split('|');

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
              localizations.gender,
              style: context.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          ListView.separated(
            physics: unscrollableScrollPhysics,
            padding: EdgeInsets.symmetric(
              horizontal: context.dx(24.0),
              vertical: context.dy(16.0),
            ),
            itemCount: genderOptions.length,
            separatorBuilder: (_, __) => const Space.vertical(16.0),
            itemBuilder: (context, index) => Clickable(
              onClick: () => ref.read(authViewModel.notifier).update(
                    currentUser: ref
                        .read(authViewModel)
                        .currentUser
                        .copyWith(gender: genderOptions[index]),
                  ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: context.dy(16.0),
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(context.dx(8.0)),
                  color: gender == genderOptions[index]
                      ? ColorName.oceanGreen
                      : transparent,
                ),
                child: Text(
                  genderOptions[index],
                  style: context.textStyle(
                    colour: gender != genderOptions[index]
                        ? ColorName.arsenic
                        : white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
