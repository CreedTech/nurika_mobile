import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/app_back_button.dart';
import '../../widgets/common/app_text_form_field.dart';
import '../../widgets/common/big_button.dart';
import '../../widgets/common/space.dart';
import 'verification_screen.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late final _formKey = GlobalKey<FormState>();

  late final _localizations = context.l10n;

  @override
  Widget build(BuildContext context) {
    final emailAddress = ref.watch(
      authViewModel.select((state) => state.emailAddress),
    );

    final isSendingCode = ref.watch(
      authViewModel.select((state) => state.isSendingCode),
    );

    final auth = ref.watch(authViewModel.notifier);

    return AnnotatedScaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.dx(24.0),
            vertical: context.dy(40.0),
          ),
          child: Form(
            key: _formKey,
            onChanged: () => _formKey.currentState!.validate(),
            child: Column(
              children: [
                const AppBackButton(),
                const Space.vertical(28.0),
                Text(
                  _localizations.forgotPassword,
                  style: context.textStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const Space.vertical(8.0),
                Text(
                  _localizations.codeWillBeSentToYou,
                  textAlign: TextAlign.center,
                  style: context.textStyle(
                    colour: ColorName.quartz,
                    fontSize: 18.0,
                  ),
                ),
                const Space.vertical(28.0),
                AppTextFormField(
                  labelText: _localizations.email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  initialValue: emailAddress,
                  validator: (value) {
                    auth.update(emailAddress: value = value!.trim());
                    return value.isNotEmpty && !value.isValidEmailAddress
                        ? _localizations.invalidEmailAddress
                        : null;
                  },
                ),
                const Space.vertical(28.0),
                BigButton(
                  isEnabled: emailAddress.isValidEmailAddress,
                  labelText: _localizations.proceed,
                  onPressed: _onProceed,
                  isBusy: isSendingCode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onProceed() {
    context.unfocus();
    final auth = ref.read(authViewModel.notifier);
    auth.sendVerificationCode().then((didSend) {
      if (didSend) {
        context.pushNamed('$VerificationScreen');
        auth.update(didForgetPassword: true);
      }
    });
  }
}
