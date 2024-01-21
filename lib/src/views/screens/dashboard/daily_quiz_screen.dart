import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../services/interfaces/http_service.dart';
import '../../../services/interfaces/storage_service.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../../viewmodels/dashboard/dashboard_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/space.dart';
import '../../widgets/dashboard/home/daily/quiz_answer_bottom_sheet.dart';
import '../../widgets/dashboard/home/daily/quiz_option_tile.dart';
import 'rewards_screen.dart';

class DailyQuizScreen extends ConsumerStatefulWidget {
  const DailyQuizScreen({super.key});

  @override
  ConsumerState<DailyQuizScreen> createState() => _DailyQuizScreenState();
}

class _DailyQuizScreenState extends ConsumerState<DailyQuizScreen> {
  late final _localizations = context.l10n;

  late var _isYetToSubmitAnswer = true;
  late var _isSubmittingAnswer = false;

  late var _explanationForAnswer = '';
  late var _selectedAnswer = '';
  late var _correctAnswer = '';

  @override
  Widget build(BuildContext context) {
    final totalPoints = ref.watch(
      authViewModel.select((state) => state.currentUser.totalPoints),
    );

    final quiz = ref.watch(
      dashboardViewModel.select((state) => state.dailyQuiz),
    );

    final isAnswerCorrect = _selectedAnswer == _correctAnswer;

    return AnnotatedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.dx(24.0)),
          child: _isYetToSubmitAnswer
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppBackButton(),
                    const Space.vertical(24.0),
                    Assets.graphics.progressBar.svg(
                      width: context.dx(380.0),
                      height: context.dy(4.0),
                      fit: BoxFit.cover,
                    ),
                    const Space.vertical(24.0),
                    Text(
                      quiz.question,
                      style: context.textStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0,
                      ),
                    ),
                    const Space.vertical(16.0),
                    Text(
                      _localizations.chooseOneCorrectAnswer,
                      style: context.textStyle(
                        colour: ColorName.arsenic,
                        fontSize: 18.0,
                      ),
                    ),
                    const Space.vertical(16.0),
                    Expanded(
                      child: ListView.separated(
                        physics: bouncingScrollPhysics,
                        itemCount: quiz.options.length,
                        separatorBuilder: (_, __) => const Space.vertical(16.0),
                        itemBuilder: (_, index) => QuizOptionTile(
                          isSelected: _selectedAnswer == quiz.options[index],
                          optionText: quiz.options[index],
                          onSelectOption: () => setState(
                            () => _selectedAnswer = quiz.options[index],
                          ),
                        ),
                      ),
                    ),
                    BigButton(
                      isBusy: _isSubmittingAnswer,
                      isEnabled: _selectedAnswer.isNotEmpty,
                      labelText: _localizations.submit,
                      onPressed: _onSubmit,
                    ),
                    const Space.vertical(24.0),
                  ],
                )
              : Column(
                  children: [
                    const AppBackButton(),
                    const Spacer(),
                    (isAnswerCorrect
                            ? Assets.images.trophy
                            : Assets.images.embarrassed)
                        .image(
                      height: context.dx(120.0),
                      width: context.dx(120.0),
                      fit: BoxFit.cover,
                    ),
                    const Space.vertical(32.0),
                    Text(
                      isAnswerCorrect
                          ? _localizations.youNailedItGreatJob
                          : _localizations.oopsYouGotItWrong,
                      style: context.textStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    ),
                    const Space.vertical(20.0),
                    Text(
                      isAnswerCorrect ? dailyQuizPoints.formatted : '0',
                      style: context.textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 36.0,
                      ),
                    ),
                    const Space.vertical(20.0),
                    Text(
                      '${_localizations.totalPoints}: ${totalPoints.formatted}',
                      style: context.textStyle(fontSize: 16.0),
                    ),
                    const Spacer(),
                    BigButton(
                      backgroundColour: !isAnswerCorrect
                          ? ColorName.warmBlack.withOpacity(0.70)
                          : null,
                      onPressed: () => context.goNamed('$RewardsScreen'),
                      labelText: !isAnswerCorrect
                          ? _localizations.tryAgainTomorrow
                          : _localizations.great,
                    ),
                    const Space.vertical(24.0),
                    BigButton(
                      onPressed: _onViewAnswer,
                      labelText: _localizations.viewAnswer,
                      foregroundColour: ColorName.warmBlack,
                      allBordersColour: ColorName.warmBlack,
                      backgroundColour: white,
                    ),
                    const Space.vertical(24.0),
                  ],
                ),
        ),
      ),
    );
  }

  void _onViewAnswer() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.dx(20.0)),
        ),
      ),
      builder: (_) => QuizAnswerBottomSheet(
        question: ref.read(dashboardViewModel).dailyQuiz.question,
        explanation: _explanationForAnswer,
        answer: _correctAnswer,
      ),
      isScrollControlled: true,
      backgroundColor: white,
      context: context,
    );
  }

  void _onSubmit() async {
    setState(() => _isSubmittingAnswer = true);

    await http
        .dispatch(
      onPositiveResponse: (response) {
        ref.read(dashboardViewModel.notifier).update(hasDoneDailyQuiz: true);
        _correctAnswer = response.data['answer'];
        _explanationForAnswer = response.data['explanation'];
        _isYetToSubmitAnswer = false;
      },
      httpRequest: http.request(
        apiEndpoint: answerQuizEndpoint,
        payload: {
          'token': storage.getString(accessTokenKey),
          'quizId': ref.read(dashboardViewModel).dailyQuiz.id,
          'answer': _selectedAnswer,
        },
        method: 'POST',
      ),
    )
        .then((didSubmit) async {
      if (didSubmit) {
        return ref.read(authViewModel.notifier).fetchCurrentUserData();
      }

      return didSubmit;
    });

    setState(() => _isSubmittingAnswer = false);
  }
}
