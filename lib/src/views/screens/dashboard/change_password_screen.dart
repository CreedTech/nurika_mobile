import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../services/interfaces/storage_service.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../services/interfaces/http_service.dart';
import '../../widgets/auth/password_strength_bar.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_text_form_field.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/screen_title_bar.dart';
import '../../widgets/common/space.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool get _isFormFilled => [_oldPassword, _newPassword, _passwordCopy]
      .every((value) => value.isNotEmpty);

  late final _formKey = GlobalKey<FormState>();

  late final _localizations = context.l10n;

  late var _isYetToChangePassword = true;
  late var _isPasswordCopyHidden = true;
  late var _isOldPasswordHidden = true;
  late var _isNewPasswordHidden = true;
  late var _isProcessing = false;
  late var _isFormValid = false;

  late var _passwordCopy = '';
  late var _oldPassword = '';
  late var _newPassword = '';

  @override
  Widget build(BuildContext context) {
    return AnnotatedScaffold(
      body: _isYetToChangePassword
          ? SafeArea(
              child: SingleChildScrollView(
                physics: bouncingScrollPhysics,
                padding: EdgeInsets.all(context.dx(24.0)),
                child: Form(
                  key: _formKey,
                  onChanged: () => setState(() {
                    _isFormValid = _formKey.currentState!.validate() &&
                        _newPassword.isValidPassword;
                  }),
                  child: Column(
                    children: [
                      ScreenTitleBar(title: _localizations.changePassword),
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
                          textAlign: TextAlign.center,
                          style: context.textStyle(
                            colour: ColorName.pantoneGreen,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      const Space.vertical(28.0),
                      AppTextFormField(
                        textInputAction: TextInputAction.next,
                        onToggleVisibility: () => setState(() {
                          _isOldPasswordHidden = !_isOldPasswordHidden;
                        }),
                        hintText: _localizations.enterYourOldPassword,
                        shouldObscureText: _isOldPasswordHidden,
                        labelText: _localizations.oldPassword,
                        validator: (value) {
                          setState(() => _oldPassword = value!);
                          return null;
                        },
                      ),
                      const Space.vertical(28.0),
                      AppTextFormField(
                        textInputAction: TextInputAction.next,
                        onToggleVisibility: () => setState(() {
                          _isNewPasswordHidden = !_isNewPasswordHidden;
                        }),
                        hintText: _localizations.enterYourNewPassword,
                        shouldObscureText: _isNewPasswordHidden,
                        labelText: _localizations.newPassword,
                        validator: (value) {
                          setState(() => _newPassword = value!);
                          return null;
                        },
                      ),
                      if (_newPassword.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: context.dy(8.0)),
                          child: PasswordStrengthBar(password: _newPassword),
                        ),
                      const Space.vertical(20.0),
                      AppTextFormField(
                        initialValue: _passwordCopy,
                        shouldObscureText: _isPasswordCopyHidden,
                        onToggleVisibility: () => setState(() {
                          _isPasswordCopyHidden = !_isPasswordCopyHidden;
                        }),
                        hintText: _localizations.enterYourPasswordAgain,
                        labelText: _localizations.confirmPassword,
                        validator: (value) {
                          setState(() => _passwordCopy = value!);
                          return value!.isNotEmpty && value != _newPassword
                              ? _localizations.passwordsDoNotMatch
                              : null;
                        },
                      ),
                      const Space.vertical(28.0),
                      BigButton(
                        onPressed: _onChange,
                        labelText: _localizations.changePassword.titleCased,
                        isEnabled: _isFormValid && _isFormFilled,
                        isBusy: _isProcessing,
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
                    _localizations.passwordHasBeenChanged,
                    style: context.textStyle(
                      colour: ColorName.quartz,
                      fontSize: 16.0,
                    ),
                  ),
                  const Space.vertical(28.0),
                  BigButton(
                    labelText: _localizations.gotIt,
                    onPressed: context.pop,
                  ),
                ],
              ),
            ),
    );
  }

  void _onChange() async {
    context.unfocus();

    setState(() => _isProcessing = true);

    final didChangePassword = await http.dispatch(
      httpRequest: http.request(
        apiEndpoint: changePasswordEndpoint,
        payload: {
          'token': storage.getString(accessTokenKey),
          'oldPassword': _oldPassword,
          'password': _newPassword,
        },
        method: 'POST',
      ),
    );

    setState(() {
      _isYetToChangePassword = !didChangePassword;
      _isProcessing = false;
    });
  }
}
