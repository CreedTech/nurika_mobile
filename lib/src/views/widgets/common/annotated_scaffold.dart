import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/extensions.dart';

class AnnotatedScaffold extends StatelessWidget {
  const AnnotatedScaffold({
    this.overlayStyle,
    this.drawer,
    this.body,
    this.tint,
    super.key,
  });

  final SystemUiOverlayStyle? overlayStyle;

  final Widget? drawer;
  final Widget? body;

  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: overlayStyle ?? context.defaultSystemUiOverlayStyle,
      child: Scaffold(backgroundColor: tint, drawer: drawer, body: body),
    );
  }
}
