import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import 'clickable.dart';

class RaisedContainer extends StatelessWidget {
  const RaisedContainer({
    required this.child,
    this.borderColour,
    this.padding,
    this.margin,
    this.onTap,
    super.key,
  });

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final GestureTapCallback? onTap;

  final Color? borderColour;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final raisedContainer = Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: context.dx(24.0)),
      padding: padding ?? EdgeInsets.all(context.dx(16.0)),
      decoration: BoxDecoration(
        border: Border.all(color: borderColour ?? transparent),
        borderRadius: BorderRadius.circular(context.dx(8.0)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(16, 24, 40, 0.05),
            offset: Offset(0.0, context.dy(1.0)),
            blurRadius: context.dx(2.0),
            spreadRadius: 0.0,
          ),
        ],
        color: white,
      ),
      child: child,
    );

    return onTap != null
        ? Clickable(onClick: onTap!, child: raisedContainer)
        : raisedContainer;
  }
}
