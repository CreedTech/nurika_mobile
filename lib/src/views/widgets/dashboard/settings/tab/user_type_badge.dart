import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/space.dart';

class UserTypeBadge extends ConsumerWidget {
  const UserTypeBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userTypeIndex = ref.watch(
      authViewModel.select((state) => state.currentUser.userTypeIndex),
    );

    final userType = context.l10n.userTypes.split('|')[userTypeIndex];

    final textColour =
        [ColorName.charcoal, const Color(0xFF026AA2)][userTypeIndex];

    final borderColour =
        [ColorName.brightGrey, const Color(0xFFB9E5FD)][userTypeIndex];

    final dotColour =
        [const Color(0xFF667085), const Color(0xFF0BA5EC)][userTypeIndex];

    final bgColour =
        [const Color(0xFFF8F9FB), const Color(0xFFF0F9FF)][userTypeIndex];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dx(16.0)),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.dx(8.0),
          vertical: context.dy(4.0),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: borderColour, width: context.dx(1.0)),
          borderRadius: BorderRadius.circular(context.dx(6.0)),
          color: bgColour,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: context.dx(8.0),
              height: context.dx(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: dotColour,
              ),
            ),
            const Space.horizontal(4.0),
            Text(
              userType,
              style: context.textStyle(
                fontWeight: FontWeight.w500,
                colour: textColour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
