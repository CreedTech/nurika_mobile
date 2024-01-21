import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../models/leaderboard/leaderboard_user.dart';
import '../../../../../viewmodels/auth/auth_view_model.dart';
import '../../../common/remote_image.dart';
import '../../../common/space.dart';

class LeaderboardUserTile extends ConsumerWidget {
  const LeaderboardUserTile({
    required this.position,
    required this.user,
    super.key,
  });

  final LeaderboardUser user;
  final int position;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(
      authViewModel.select((state) => state.currentUser.userId),
    );

    final localizations = context.l10n;

    return Container(
      padding: EdgeInsets.all(context.dx(16.0)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.dx(8.0)),
        color: user.userId == currentUserId
            ? const Color.fromRGBO(202, 218, 254, 0.30)
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: context.dx(24.0),
            child: Text(
              position.formatted,
              style: context.textStyle(
                colour: ColorName.manatee,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
          const Space.horizontal(20.0),
          ClipOval(
            child: RemoteImage(
              iconData: Icons.person_3_outlined,
              imageUrl: user.profileImage,
              iconSize: context.dx(18.0),
              size: context.dx(36.0),
            ),
          ),
          const Space.horizontal(8.0),
          Expanded(
            child: Text(
              user.userId == currentUserId ? localizations.you : user.firstName,
              style: context.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ),
          const Space.horizontal(20.0),
          Text(
            '${user.points.formatted} ${localizations.points}',
            style: context.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
