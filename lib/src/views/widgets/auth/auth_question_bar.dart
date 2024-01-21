import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/extensions.dart';

class AuthQuestionBar extends StatelessWidget {
  const AuthQuestionBar({
    required this.question,
    required this.action,
    required this.onTap,
    super.key,
  });

  final GestureTapCallback onTap;

  final String question;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: context.textStyle(
            colour: ColorName.outerSpace,
            fontSize: 18.0,
          ),
          children: [
            TextSpan(text: '$question '),
            TextSpan(
              style: const TextStyle(color: ColorName.warmBlack),
              recognizer: TapGestureRecognizer()..onTap = onTap,
              text: action,
            ),
          ],
        ),
      ),
    );
  }
}
