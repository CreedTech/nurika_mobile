import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../../../models/team/referral_team_member.dart';
import '../../../common/remote_image.dart';
import '../../../common/space.dart';

class ReferralTeamMemberTile extends StatelessWidget {
  const ReferralTeamMemberTile({required this.member, super.key});

  final ReferralTeamMember member;

  @override
  Widget build(BuildContext context) {
    final dateFormat = member.dateJoined.year != DateTime.now().year
        ? DateFormat('MMMM d, y')
        : DateFormat('MMMM d');

    return Row(
      children: [
        ClipOval(
          child: RemoteImage(
            iconData: Icons.person_3_outlined,
            imageUrl: member.profileImage,
            iconSize: context.dx(18.0),
            size: context.dx(36.0),
          ),
        ),
        const Space.horizontal(12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              member.firstName,
              style: context.textStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            Text(
              '${context.l10n.joined} ${dateFormat.format(member.dateJoined)}',
              style: context.textStyle(
                colour: ColorName.quartz,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
