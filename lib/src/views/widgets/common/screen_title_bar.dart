import 'package:flutter/material.dart';

import '../../../core/extensions.dart';
import 'app_back_button.dart';
import 'space.dart';

class ScreenTitleBar extends StatelessWidget {
  const ScreenTitleBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppBackButton(),
        Text(
          title,
          style: context.textStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18.0,
          ),
        ),
        const Space.horizontal(24.0),
      ],
    );
  }
}
