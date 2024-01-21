import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/auth/auth_question_bar.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_text_form_field.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/space.dart';
import '../dashboard/dashboard_screen.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late final _formKey = GlobalKey<FormState>();

  late final _localizations = context.l10n;

  late var _isPasswordHidden = true;
  late var _isFormValid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _onFormChanged());
  }

  @override
  Widget build(BuildContext context) {
    final password = ref.watch(authViewModel.select((state) => state.password));

    final emailAddress = ref.watch(
      authViewModel.select((state) => state.emailAddress),
    );

    final isProcessing = ref.watch(
      authViewModel.select((state) => state.isProcessing),
    );

    final isFormFilled =
        [emailAddress, password].every((value) => value.isNotEmpty);

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
            onChanged: _onFormChanged,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _localizations.welcomeBack,
                  style: context.textStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                  ),
                ),
                const Space.vertical(6.0),
                Text(
                  _localizations.logInToContinue,
                  style: context.textStyle(
                    colour: ColorName.outerSpace,
                    fontSize: 18.0,
                  ),
                ),
                const Space.vertical(28.0),
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
                const Space.vertical(16.0),
                AppTextFormField(
                  initialValue: password,
                  shouldObscureText: _isPasswordHidden,
                  onToggleVisibility: () => setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  }),
                  hintText: _localizations.enterYourPassword,
                  labelText: _localizations.password,
                  validator: (value) {
                    auth.update(password: value!);
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () => context.pushNamed('$ForgotPasswordScreen'),
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  ),
                  child: Text(
                    _localizations.forgotPasswrd,
                    style: context.textStyle(
                      colour: ColorName.warmBlack,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const Space.vertical(16.0),
                BigButton(
                  isEnabled: _isFormValid && isFormFilled,
                  labelText: _localizations.logIn,
                  onPressed: _onSignIn,
                  isBusy: isProcessing,
                ),
                const Space.vertical(42.0),
                AuthQuestionBar(
                  onTap: () => context.pushReplacementNamed('$SignUpScreen'),
                  question: _localizations.doNotHaveAnAccount,
                  action: _localizations.signUp,
                ),
                const Space.vertical(64.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormChanged() {
    setState(() => _isFormValid = _formKey.currentState!.validate());
  }

  void _onSignIn() {
    context.unfocus();
    ref.read(authViewModel.notifier).signIn().then((didSignIn) {
      if (didSignIn) {
        context.goNamed('$DashboardScreen');
      }
    });
  }
}
