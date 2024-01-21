import 'package:flutter/material.dart';

import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/extensions.dart';
import '../../../common/space.dart';

class QuizAnswerBottomSheet extends StatelessWidget {
  const QuizAnswerBottomSheet({
    required this.explanation,
    required this.question,
    required this.answer,
    super.key,
  });

  final String explanation;
  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(context.dx(24.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              localizations.question,
              style: context.textStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            const Space.vertical(8.0),
            Text(
              question,
              textAlign: TextAlign.justify,
              style: context.textStyle(
                colour: ColorName.arsenic,
                fontSize: 16.0,
              ),
            ),
            const Space.vertical(16.0),
            Container(
              padding: EdgeInsets.all(context.dx(16.0)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.dx(8.0)),
                color: const Color(0xFFE9EBFA),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${localizations.theCorrectAnswerIs} "$answer"',
                    style: context.textStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  const Space.vertical(20.0),
                  Text(
                    localizations.explanation,
                    style: context.textStyle(fontWeight: FontWeight.w600),
                  ),
                  const Space.vertical(8.0),
                  Text(
                    explanation,
                    textAlign: TextAlign.justify,
                    style: context.textStyle(
                      colour: ColorName.arsenic,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
