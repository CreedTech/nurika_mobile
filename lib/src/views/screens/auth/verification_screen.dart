import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/simple_loading_indicator.dart';
import '../../widgets/common/space.dart';
import 'reset_password_screen.dart';
import 'sign_in_screen.dart';

class VerificationScreen extends ConsumerStatefulWidget {
  const VerificationScreen({super.key});

  @override
  ConsumerState<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends ConsumerState<VerificationScreen> {
  late final _localizations = context.l10n;

  late var _isYetToVerifyCode = true;
  late var _didVerifyCode = false;

  @override
  Widget build(BuildContext context) {
    final otpCode = ref.watch(authViewModel.select((state) => state.otpCode));

    final timeLeft = ref.watch(authViewModel.select((state) => state.timeLeft));

    final didForgetPassword = ref.watch(
      authViewModel.select((state) => state.didForgetPassword),
    );

    final isSendingCode = ref.watch(
      authViewModel.select((state) => state.isSendingCode),
    );

    final emailAddress = ref.watch(
      authViewModel.select((state) => state.emailAddress),
    );

    final isProcessing = ref.watch(
      authViewModel.select((state) => state.isProcessing),
    );

    final auth = ref.watch(authViewModel.notifier);

    return AnnotatedScaffold(
      body: _isYetToVerifyCode
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.dx(24.0),
                  vertical: context.dy(40.0),
                ),
                child: Column(
                  children: [
                    const AppBackButton(),
                    const Space.vertical(28.0),
                    Text(
                      _localizations.verifyEmailAddress,
                      style: context.textStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    const Space.vertical(8.0),
                    Text(
                      '${_localizations.pleaseEnterTheCode}\n$emailAddress',
                      textAlign: TextAlign.center,
                      style: context.textStyle(
                        colour: ColorName.quartz,
                        fontSize: 18.0,
                      ),
                    ),
                    const Space.vertical(28.0),
                    TextFormField(
                      style: context.textStyle(fontSize: 40.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: context.dy(12.0)),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorName.chineseBlack),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorName.lightSilver),
                        ),
                        counter: const SizedBox.shrink(),
                      ),
                      cursorColor: ColorName.chineseBlack,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      initialValue: otpCode,
                      maxLength: codeLength,
                      onChanged: (value) {
                        auth.update(otpCode: value);
                        if (value.length == codeLength) {
                          context.unfocus();
                        }
                      },
                    ),
                    const Space.vertical(28.0),
                    BigButton(
                      isEnabled: otpCode.length == codeLength,
                      labelText: _localizations.submit,
                      onPressed: _onVerify,
                      isBusy: isProcessing,
                    ),
                    const Space.vertical(28.0),
                    if (timeLeft > 0) ...[
                      Text(
                        _localizations.weHaveSentYou,
                        style: context.textStyle(
                          colour: ColorName.outerSpace,
                          fontSize: 18.0,
                        ),
                      ),
                      const Space.vertical(4.0),
                      Text(
                        timeLeft.asShortTimeString,
                        style: context.textStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ] else if (isSendingCode)
                      const SimpleLoadingIndicator(
                        colours: [ColorName.outerSpace],
                        height: 36.0,
                      )
                    else
                      TextButton(
                        onPressed: auth.sendVerificationCode,
                        child: Text(
                          _localizations.clickToResend,
                          style: context.textStyle(
                            colour: ColorName.outerSpace,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_didVerifyCode
                          ? Assets.images.tickIcon
                          : Assets.images.closeIcon)
                      .image(
                    height: context.dx(72.0),
                    width: context.dx(72.0),
                    fit: BoxFit.cover,
                  ),
                  const Space.vertical(28.0),
                  Text(
                    _didVerifyCode
                        ? _localizations.success
                        : _localizations.error,
                    style: context.textStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                  const Space.vertical(8.0),
                  Text(
                    _didVerifyCode
                        ? _localizations.emailHasBeenVerified
                        : _localizations.emailVerificationFailed,
                    style: context.textStyle(
                      colour: ColorName.quartz,
                      fontSize: 18.0,
                    ),
                  ),
                  const Space.vertical(28.0),
                  BigButton(
                    labelText: _didVerifyCode
                        ? _localizations.gotIt
                        : _localizations.tryAgain,
                    onPressed: () {
                      if (_didVerifyCode) {
                        if (didForgetPassword) {
                          context.pushReplacementNamed('$ResetPasswordScreen');
                        } else {
                          context.goNamed('$SignInScreen');
                        }
                      } else {
                        setState(() => _isYetToVerifyCode = true);
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }

  void _onVerify() {
    context.unfocus();
    ref.read(authViewModel.notifier).verifyCode().then((didVerifyCode) {
      setState(() {
        _didVerifyCode = didVerifyCode;
        _isYetToVerifyCode = false;
      });
    });
  }
}
