import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_user.freezed.dart';
part 'leaderboard_user.g.dart';

@freezed
class LeaderboardUser with _$LeaderboardUser {
  const factory LeaderboardUser({
    @Default('') String profileImage,
    @Default('') String firstName,
    @Default('') String userId,
    @Default(0) int points,
  }) = _LeaderboardUser;

  factory LeaderboardUser.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardUserFromJson(json);
}
