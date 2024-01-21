import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/space.dart';
import '../auth/sign_in_screen.dart';
import '../auth/sign_up_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final _localizations = context.l10n;

  late final _infoTexts = [
    _localizations.useNurikaToTrack,
    _localizations.nurikaProvidesYou,
    _localizations.takeProactiveApproach,
    _localizations.useYourRewards,
  ];

  late final _frames = [
    Assets.graphics.onboardingFrameOne,
    Assets.graphics.onboardingFrameTwo,
    Assets.graphics.onboardingFrameThree,
    Assets.graphics.onboardingFrameFour,
  ];

  late var _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _playCarousel();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedScaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Space.vertical(32.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var index = 0; index < _frames.length; index++)
                    AnimatedContainer(
                      width: context.dx(84.0),
                      height: context.dy(4.0),
                      duration: 512.milliseconds,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(context.dx(24.0)),
                        color: index > _pageIndex
                            ? ColorName.azureishWhite
                            : ColorName.warmBlack,
                      ),
                    ),
                ],
              ),
            ),
            const Space.vertical(70.0),
            AnimatedSwitcher(
              duration: 512.milliseconds,
              child: _frames[_pageIndex].svg(
                key: Key(_frames[_pageIndex].path),
                height: context.dy(325.0),
                width: context.dx(428.0),
                fit: BoxFit.cover,
              ),
            ),
            const Space.vertical(40.0),
            AnimatedSwitcher(
              duration: 512.milliseconds,
              child: Container(
                key: Key(_infoTexts[_pageIndex]),
                padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
                alignment: Alignment.topCenter,
                height: context.dy(164.0),
                child: Text(
                  _infoTexts[_pageIndex],
                  textAlign: TextAlign.center,
                  style: context.textStyle(fontSize: 20.0),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
              child: BigButton(
                onPressed: () => context.pushNamed('$SignUpScreen'),
                labelText: _localizations.createNewAccount,
              ),
            ),
            const Space.vertical(24.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
              child: BigButton(
                labelText: _localizations.logInIfHaveAnAccount,
                onPressed: () => context.pushNamed('$SignInScreen'),
                foregroundColour: ColorName.darkJungleGreen,
                allBordersColour: ColorName.lightSilver,
                backgroundColour: white,
                fontSize: 14.0,
              ),
            ),
            const Space.vertical(64.0),
          ],
        ),
      ),
    );
  }

  void _playCarousel() async {
    while (true) {
      await 8.seconds.delay;
      if (mounted) {
        setState(() => _pageIndex = (_pageIndex + 1) % _frames.length);
      }
    }
  }
}
