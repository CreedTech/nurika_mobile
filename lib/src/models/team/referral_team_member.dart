import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral_team_member.freezed.dart';
part 'referral_team_member.g.dart';

@freezed
class ReferralTeamMember with _$ReferralTeamMember {
  const ReferralTeamMember._();

  const factory ReferralTeamMember({
    @Default('') String profileImage,
    @Default('') String firstName,
    @Default('') String createdAt,
  }) = _ReferralTeamMember;

  factory ReferralTeamMember.fromJson(Map<String, dynamic> json) =>
      _$ReferralTeamMemberFromJson(json);

  DateTime get dateJoined => DateTime.parse(createdAt);
}
