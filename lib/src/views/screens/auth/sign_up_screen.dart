import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/auth/auth_question_bar.dart';
import '../../widgets/auth/password_strength_bar.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_text_form_field.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/space.dart';
import 'sign_in_screen.dart';
import 'verification_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  late final _formKey = GlobalKey<FormState>();

  late final _localizations = context.l10n;

  late var _isPasswordCopyHidden = true;
  late var _isPasswordHidden = true;
  late var _isFormValid = false;

  late var _password = '';

  @override
  Widget build(BuildContext context) {
    final password = ref.watch(authViewModel.select((state) => state.password));

    final referralCode = ref.watch(
      authViewModel.select((state) => state.referralCode),
    );

    final emailAddress = ref.watch(
      authViewModel.select((state) => state.emailAddress),
    );

    final isProcessing = ref.watch(
      authViewModel.select((state) => state.isProcessing),
    );

    final firstName = ref.watch(
      authViewModel.select((state) => state.firstName),
    );

    final lastName = ref.watch(
      authViewModel.select((state) => state.lastName),
    );

    final isFormFilled = [emailAddress, password, _password, firstName]
        .every((value) => value.isNotEmpty);

    final auth = ref.watch(authViewModel.notifier);

    return AnnotatedScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          padding: EdgeInsets.symmetric(
            horizontal: context.dx(24.0),
            vertical: context.dy(40.0),
          ),
          child: Form(
            key: _formKey,
            onChanged: () => setState(() {
              _isFormValid =
                  _formKey.currentState!.validate() && password.isValidPassword;
            }),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _localizations.welcomeToNurika,
                  style: context.textStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                const Space.vertical(8.0),
                Text(
                  _localizations.enterYourDetails,
                  style: context.textStyle(
                    colour: ColorName.outerSpace,
                    fontSize: 18.0,
                  ),
                ),
                const Space.vertical(24.0),
                /* ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: ColorName.lightSilver),
                      borderRadius: BorderRadius.circular(context.dx(8.0)),
                    ),
                    padding: EdgeInsets.symmetric(vertical: context.dy(10.0)),
                    backgroundColor: white,
                    elevation: 0.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.graphics.google.svg(
                        height: context.dx(24.0),
                        width: context.dx(24.0),
                        fit: BoxFit.cover,
                      ),
                      const Space.horizontal(12.0),
                      Text(
                        _localizations.continueWithGoogle,
                        style: context.textStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ), */
                const Space.vertical(24.0),
                AppTextFormField(
                  hintText: _localizations.enterYourFirstName,
                  textInputAction: TextInputAction.next,
                  labelText: _localizations.firstName,
                  initialValue: firstName.trim(),
                  validator: (value) {
                    auth.update(firstName: value = value!.trim());
                    return value.isNotEmpty && value.length < 3
                        ? _localizations.invalidName
                        : null;
                  },
                ),
                const Space.vertical(20.0),
                AppTextFormField(
                  hintText: _localizations.enterYourLastName,
                  textInputAction: TextInputAction.next,
                  labelText: _localizations.lastName,
                  initialValue: lastName.trim(),
                  validator: (value) {
                    auth.update(lastName: value = value!.trim());
                    return value.isNotEmpty && value.length < 3
                        ? _localizations.invalidName
                        : null;
                  },
                ),
                const Space.vertical(20.0),
                AppTextFormField(
                  hintText: _localizations.enterYourEmailAddress,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  initialValue: emailAddress.trim(),
                  labelText: _localizations.email,
                  validator: (value) {
                    auth.update(emailAddress: value = value!.trim());
                    return value.isNotEmpty && !value.isValidEmailAddress
                        ? _localizations.invalidEmailAddress
                        : null;
                  },
                ),
                const Space.vertical(20.0),
                AppTextFormField(
                  hintText: _localizations.enterYourReferralCode,
                  labelText: _localizations.referralCode,
                  textInputAction: TextInputAction.next,
                  initialValue: referralCode.trim(),
                  validator: (value) {
                    auth.update(referralCode: value = value!.trim());
                    return value.isNotEmpty && !value.isValidReferralCode
                        ? _localizations.invalidReferralCode
                        : null;
                  },
                  maxLength: 6,
                ),
                const Space.vertical(20.0),
                AppTextFormField(
                  initialValue: password,
                  textInputAction: TextInputAction.next,
                  onToggleVisibility: () => setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  }),
                  hintText: _localizations.enterYourPassword,
                  shouldObscureText: _isPasswordHidden,
                  labelText: _localizations.password,
                  validator: (value) {
                    auth.update(password: value!);
                    return null;
                  },
                ),
                const Space.vertical(6.0),
                if (password.isNotEmpty)
                  PasswordStrengthBar(password: password)
                else
                  Text(
                    _localizations.passwordMustBe,
                    style: context.textStyle(
                      colour: ColorName.independence,
                      fontSize: 13.0,
                    ),
                  ),
                const Space.vertical(20.0),
                AppTextFormField(
                  initialValue: _password,
                  shouldObscureText: _isPasswordCopyHidden,
                  onToggleVisibility: () => setState(() {
                    _isPasswordCopyHidden = !_isPasswordCopyHidden;
                  }),
                  hintText: _localizations.enterYourPasswordAgain,
                  labelText: _localizations.confirmPassword,
                  validator: (value) {
                    setState(() => _password = value!);
                    return value!.isNotEmpty && value != password
                        ? _localizations.passwordsDoNotMatch
                        : null;
                  },
                ),
                const Space.vertical(60.0),
                BigButton(
                  isEnabled: _isFormValid && isFormFilled,
                  labelText: _localizations.createAccount,
                  onPressed: _onSignUp,
                  isBusy: isProcessing,
                ),
                const Space.vertical(22.0),
                AuthQuestionBar(
                  question: _localizations.alreadyHaveAnAccount,
                  action: _localizations.logIn,
                  onTap: () {
                    context.pushReplacementNamed('$SignInScreen');
                  },
                ),
                const Space.vertical(38.0),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.textStyle(
                        colour: ColorName.quartz,
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text: '${_localizations.byCreatingAnAccount}\n',
                        ),
                        TextSpan(
                          text: _localizations.termsOfService,
                          style: const TextStyle(color: ColorName.brandeisBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _goToSite(termsOfServiceLink),
                        ),
                        TextSpan(text: ' ${_localizations.and} '),
                        TextSpan(
                          text: _localizations.privacyPolicy,
                          style: const TextStyle(color: ColorName.brandeisBlue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _goToSite(privacyPolicyLink),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToSite(String url) {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  void _onSignUp() {
    context.unfocus();
    ref.read(authViewModel.notifier).signUp().then((didSignUp) {
      if (didSignUp) {
        context.pushNamed('$VerificationScreen');
      }
    });
  }
}
