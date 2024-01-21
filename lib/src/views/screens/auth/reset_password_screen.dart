import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/auth/password_strength_bar.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/app_text_form_field.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/space.dart';
import 'sign_in_screen.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  late final _formKey = GlobalKey<FormState>();

  late final _localizations = context.l10n;

  late var _isYetToResetPassword = true;
  late var _isPasswordCopyHidden = true;
  late var _isPasswordHidden = true;
  late var _isFormValid = false;

  late var _password = '';

  @override
  Widget build(BuildContext context) {
    final password = ref.watch(authViewModel.select((state) => state.password));

    final isProcessing = ref.watch(
      authViewModel.select((state) => state.isProcessing),
    );

    final isFormFilled =
        [password, _password].every((value) => value.isNotEmpty);

    return AnnotatedScaffold(
      body: _isYetToResetPassword
          ? SafeArea(
              child: SingleChildScrollView(
                physics: bouncingScrollPhysics,
                padding: EdgeInsets.symmetric(
                  horizontal: context.dx(24.0),
                  vertical: context.dy(40.0),
                ),
                child: Form(
                  key: _formKey,
                  onChanged: () => setState(() {
                    _isFormValid = _formKey.currentState!.validate() &&
                        password.isValidPassword;
                  }),
                  child: Column(
                    children: [
                      const AppBackButton(),
                      const Space.vertical(28.0),
                      Text(
                        _localizations.resetPassword,
                        style: context.textStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                      const Space.vertical(8.0),
                      Text(
                        _localizations.enterYourNewPassword,
                        textAlign: TextAlign.center,
                        style: context.textStyle(
                          colour: ColorName.quartz,
                          fontSize: 18.0,
                        ),
                      ),
                      const Space.vertical(28.0),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.dx(16.0),
                          vertical: context.dy(8.0),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(context.dx(8.0)),
                          color: ColorName.pantoneGreen.withOpacity(0.05),
                        ),
                        child: Text(
                          _localizations.passwordMustBe,
                          style: context.textStyle(
                            colour: ColorName.pantoneGreen,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const Space.vertical(28.0),
                      AppTextFormField(
                        initialValue: password,
                        textInputAction: TextInputAction.next,
                        onToggleVisibility: () => setState(() {
                          _isPasswordHidden = !_isPasswordHidden;
                        }),
                        hintText: _localizations.enterYourNewPassword,
                        shouldObscureText: _isPasswordHidden,
                        labelText: _localizations.password,
                        validator: (value) {
                          ref
                              .read(authViewModel.notifier)
                              .update(password: value!);
                          return null;
                        },
                      ),
                      if (password.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: context.dy(8.0)),
                          child: PasswordStrengthBar(password: password),
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
                      const Space.vertical(28.0),
                      BigButton(
                        onPressed: _onChange,
                        labelText: _localizations.resetPassword.titleCased,
                        isEnabled: _isFormValid && isFormFilled,
                        isBusy: isProcessing,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: context.dx(24.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.tickIcon.image(
                    height: context.dy(72.0),
                    width: context.dx(72.0),
                    fit: BoxFit.cover,
                  ),
                  const Space.vertical(28.0),
                  Text(
                    _localizations.success,
                    style: context.textStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const Space.vertical(8.0),
                  Text(
                    _localizations.passwordHasBeenReset,
                    style: context.textStyle(
                      colour: ColorName.quartz,
                      fontSize: 18.0,
                    ),
                  ),
                  const Space.vertical(28.0),
                  BigButton(
                    labelText: _localizations.logIn,
                    onPressed: () => context.goNamed('$SignInScreen'),
                  ),
                ],
              ),
            ),
    );
  }

  void _onChange() {
    context.unfocus();
    ref.read(authViewModel.notifier).resetPassword().then(
          (didChange) => setState(() => _isYetToResetPassword = !didChange),
        );
  }
}
