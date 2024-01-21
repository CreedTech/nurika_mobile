import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../core/extensions.dart';

class HyperClickable extends StatefulWidget {
  const HyperClickable({
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
  State<HyperClickable> createState() => _HyperClickableState();
}

class _HyperClickableState extends State<HyperClickable> {
  late var _isHyperActive = false;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(256.milliseconds, (_) {
      if (_isHyperActive) {
        widget.onClick();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: widget.highlightColor ?? transparent,
      splashColor: widget.splashColor ?? transparent,
      onTapCancel: () =>  _isHyperActive = false,
      onTapDown: (_) =>  _isHyperActive = true,
      onTapUp: (_) =>  _isHyperActive = false,
      child: widget.child,
    );
  }
}
