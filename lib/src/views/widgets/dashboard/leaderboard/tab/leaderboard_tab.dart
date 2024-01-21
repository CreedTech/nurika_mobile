import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../../models/leaderboard/leaderboard_user.dart';
import '../../../../../services/interfaces/http_service.dart';
import '../../../../../services/interfaces/storage_service.dart';
import '../../../../screens/dashboard/referral_team_screen.dart';
import '../../../common/space.dart';
import 'leaderboard_user_tile.dart';

class LeaderboardTab extends StatefulWidget {
  const LeaderboardTab({super.key});

  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  late final _leaderboardUsers = storage
      .getStringList(leaderboardUsersKey)
      .map((value) => LeaderboardUser.fromJson(jsonDecode(value)))
      .toList();

  late final _localizations = context.l10n;

  @override
  void initState() {
    super.initState();
    _fetchLeaderboardUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
      child: Column(
        children: [
          const Space.vertical(24.0),
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                _localizations.leaderboard,
                style: context.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => context.pushNamed('$ReferralTeamScreen'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(context.dx(8.0)),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: context.dx(12.0),
                      vertical: context.dy(6.0),
                    ),
                    backgroundColor: ColorName.oceanGreen,
                    elevation: 0.0,
                  ),
                  child: Text(
                    _localizations.viewTeam,
                    style: context.textStyle(
                      fontWeight: FontWeight.w500,
                      colour: white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _leaderboardUsers.isEmpty
                ? Center(
                    child: Text(
                      _localizations.noMembersYet,
                      style: context.textStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                : ListView.separated(
                    physics: bouncingScrollPhysics,
                    itemCount: _leaderboardUsers.length,
                    padding: EdgeInsets.only(top: context.dy(24.0)),
                    separatorBuilder: (_, __) => const Space.vertical(16.0),
                    itemBuilder: (_, index) => LeaderboardUserTile(
                      user: _leaderboardUsers[index],
                      position: index + 1,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _fetchLeaderboardUsers() async {
    while (true) {
      if (storage.has(accessTokenKey)) {
        await http.dispatch(
          onPositiveResponse: (response) {
            if (mounted) {
              setState(() {
                _leaderboardUsers
                  ..clear()
                  ..addAll(
                    (response.data as List)
                        .map((value) => LeaderboardUser.fromJson(value)),
                  );
              });
            }

            storage.setStringList(
              leaderboardUsersKey,
              [..._leaderboardUsers.map(jsonEncode)],
            );
          },
          httpRequest: http.request(
            payload: {'token': storage.getString(accessTokenKey)},
            apiEndpoint: leaderboardEndpoint,
            method: 'POST',
          ),
          isObvious: false,
        );
      }

      await 8.seconds.delay;
    }
  }
}
