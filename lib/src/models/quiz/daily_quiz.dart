import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/extensions.dart';

part 'daily_quiz.freezed.dart';
part 'daily_quiz.g.dart';

@freezed
class DailyQuiz with _$DailyQuiz {
  const DailyQuiz._();

  const factory DailyQuiz({
    @Default('') @JsonKey(name: '_id') String id,
    @Default('2000-01-01') String scheduledFor,
    @Default([]) List<String> options,
    @Default('') String question,
  }) = _DailyQuiz;

  factory DailyQuiz.fromJson(Map<String, dynamic> json) =>
      _$DailyQuizFromJson(json);

  bool get hasExpired =>
      DateTime.parse(scheduledFor).asYyMmDd != DateTime.now().asYyMmDd;
}
