import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../../screens/dashboard/profile_screen.dart';
import '../../../common/clickable.dart';
import '../../../common/space.dart';
import '../../../common/user_avatar_circle.dart';

class HelloHeader extends ConsumerWidget {
  const HelloHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstName = ref.watch(
      authViewModel.select((state) => state.currentUser.firstName),
    );

    final localizations = context.l10n;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
      child: Row(
        children: [
          Clickable(
            onClick: () => context.pushNamed('$ProfileScreen'),
            child: const UserAvatarCircle(),
          ),
          const Space.horizontal(8.0),
          Text(
            '${localizations.hello} $firstName',
            style: context.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
