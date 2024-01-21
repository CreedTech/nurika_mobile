import 'package:flutter/material.dart';

import '../../../core/extensions.dart';

class Space extends StatelessWidget {
  const Space.horizontal(this.width, {super.key}) : height = null;

  const Space.vertical(this.height, {super.key}) : width = null;

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height != null ? context.dy(height!) : null,
      width: width != null ? context.dx(width!) : null,
    );
  }
}
