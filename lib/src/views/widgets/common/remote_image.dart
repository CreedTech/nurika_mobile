import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';

class RemoteImage extends StatelessWidget {
  const RemoteImage({
    required this.imageUrl,
    this.hasPlaceholder = true,
    this.iconData,
    this.iconSize,
    this.height,
    this.width,
    this.size,
    super.key,
  });

  final double? size;
  final double? width;
  final double? height;
  final double? iconSize;

  final bool hasPlaceholder;

  final IconData? iconData;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Container circled(Widget? child) {
      return Container(
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(color: ColorName.oceanGreen),
          ),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        height: size ?? height,
        width: size ?? width,
        child: child,
      );
    }

    return CachedNetworkImage(
      placeholder: (_, __) => circled(
        hasPlaceholder
            ? Shimmer.fromColors(
                highlightColor: white,
                baseColor: ColorName.oceanGreen,
                child: Icon(iconData, size: iconSize),
              )
            : null,
      ),
      errorWidget: (_, __, ___) => circled(
        Icon(
          Icons.error,
          color: ColorName.carminePink,
          size: iconSize,
        ),
      ),
      imageUrl: imageUrl,
      height: size ?? height,
      width: size ?? width,
      fit: BoxFit.cover,
    );
  }
}
