import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/dashboard/dashboard_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/clickable.dart';
import '../../widgets/common/space.dart';
import 'daily_quiz_screen.dart';

class DailyQuizIntroScreen extends ConsumerWidget {
  const DailyQuizIntroScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isYetToLoadDailyQuiz = ref.watch(
      dashboardViewModel.select((state) => state.dailyQuiz.hasExpired),
    );

    final hasDoneDailyQuiz = ref.watch(
      dashboardViewModel.select((state) => state.hasDoneDailyQuiz),
    );

    final localizations = context.l10n;

    return AnnotatedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(context.dx(24.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppBackButton(),
              const Space.vertical(24.0),
              Text(
                localizations.dailyQuiz,
                style: context.textStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 30.0,
                ),
              ),
              const Space.vertical(8.0),
              Text(
                localizations.getPointsEveryday(dailyQuizPoints),
                style: context.textStyle(
                  colour: ColorName.darkJungleGreen,
                  fontWeight: FontWeight.w300,
                  fontSize: 16.0,
                ),
              ),
              const Space.vertical(24.0),
              Clickable(
                onClick: () => launchUrl(
                  Uri.parse(socialLinks[2]),
                  mode: LaunchMode.externalApplication,
                ),
                child: Container(
                  padding: EdgeInsets.all(context.dx(16.0)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.dx(8.0)),
                    color: const Color.fromRGBO(202, 218, 254, 0.30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Assets.graphics.telegram.svg(
                        height: context.dx(40.0),
                        width: context.dx(40.0),
                        fit: BoxFit.cover,
                      ),
                      const Space.horizontal(8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              localizations.lookingForHints,
                              style: context.textStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 22.0,
                              ),
                            ),
                            const Space.vertical(8.0),
                            Text(
                              localizations.visitOurTelegram,
                              style: context.textStyle(
                                colour: ColorName.warmBlack,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Space.vertical(16.0),
              Padding(
                padding: EdgeInsets.all(context.dx(16.0)),
                child: Row(
                  children: [
                    Assets.graphics.circledGreenCoin.svg(
                      height: context.dx(40.0),
                      width: context.dx(40.0),
                      fit: BoxFit.cover,
                    ),
                    const Space.horizontal(8.0),
                    Expanded(
                      child: Text(
                        localizations.guessItRight,
                        style: context.textStyle(
                          colour: ColorName.quartz,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Space.vertical(16.0),
              Padding(
                padding: EdgeInsets.all(context.dx(16.0)),
                child: Row(
                  children: [
                    Assets.graphics.tealCircledQuestionMessage.svg(
                      height: context.dx(40.0),
                      width: context.dx(40.0),
                      fit: BoxFit.cover,
                    ),
                    const Space.horizontal(8.0),
                    Text(
                      localizations.quizReleasedEveryday,
                      style: context.textStyle(
                        colour: ColorName.quartz,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BigButton(
                onPressed: () => context.pushNamed('$DailyQuizScreen'),
                labelText: localizations.goToQuiz,
                isEnabled: !hasDoneDailyQuiz,
                isBusy: isYetToLoadDailyQuiz,
              ),
              const Space.vertical(24.0),
            ],
          ),
        ),
      ),
    );
  }
}
