import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../../screens/dashboard/profile_screen.dart';
import '../../../common/clickable.dart';
import '../../../common/space.dart';
import '../../../common/user_avatar_circle.dart';
import 'user_type_badge.dart';

class UserInfoHeader extends ConsumerWidget {
  const UserInfoHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullName = ref.watch(
      authViewModel.select((state) => state.currentUser.fullName),
    );

    final email = ref.watch(
      authViewModel.select((state) => state.currentUser.email),
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dx(16.0)),
      child: Column(
        children: [
          Clickable(
            onClick: () => context.pushNamed('$ProfileScreen'),
            child: const UserAvatarCircle(size: 80.0),
          ),
          const Space.vertical(8.0),
          Text(
            fullName,
            style: context.textStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          const Space.vertical(8.0),
          Text(
            email,
            style: context.textStyle(colour: ColorName.quartz, fontSize: 16.0),
          ),
          const Space.vertical(8.0),
          const UserTypeBadge(),
        ],
      ),
    );
  }
}
