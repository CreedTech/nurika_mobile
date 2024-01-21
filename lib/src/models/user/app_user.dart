import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const AppUser._();

  const factory AppUser({
    @Default('') String email,
    @Default('') String userId,
    @Default('') String gender,
    @Default('') String username,
    @Default('') String lastName,
    @Default('') String firstName,
    @Default('') String referralId,
    @Default('') String dateOfBirth,
    @Default('') String profileImage,
    @Default('cm') String heightUnit,
    @Default('kg') String weightUnit,
    @Default([]) List<Map<String, dynamic>> pointsRecord,
    @Default([]) List<Map<String, dynamic>> stepsRecord,
    @Default([]) List<Map<String, String>> referrals,
    @Default(0) int dailyStepsTarget,
    @Default(0) int stepCountToday,
    @Default(0) int userTypeIndex,
    @Default(0) int totalPoints,
    @Default(0) int bodyHeight,
    @Default(0) int bodyWeight,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  String get fullName => '$firstName $lastName';

  int get age {
    if (dateOfBirth.isEmpty) {
      return 0;
    }

    final birthDate = DateTime.parse(dateOfBirth), today = DateTime.now();
    final answer = today.year - birthDate.year;

    return today.month < birthDate.month ||
            (today.month == birthDate.month && today.day < birthDate.day)
        ? answer - 1
        : answer;
  }
}
