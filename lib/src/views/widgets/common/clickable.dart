import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class Clickable extends StatelessWidget {
  const Clickable({
    required this.child,
    required this.onClick,
    this.highlightColor,
    this.splashColor,
    super.key,
  });

  final GestureTapCallback onClick;

  final Color? highlightColor;
  final Color? splashColor;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: highlightColor ?? transparent,
      splashColor: splashColor ?? transparent,
      onTap: onClick,
      child: child,
    );
  }
}
