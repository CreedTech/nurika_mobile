import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import 'remote_image.dart';

class UserAvatarCircle extends ConsumerWidget {
  const UserAvatarCircle({this.size = 32.0, super.key});

  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final base64Dp = ref.watch(authViewModel.select((state) => state.base64Dp));

    final profileImage = ref.watch(
      authViewModel.select((state) => state.currentUser.profileImage),
    );

    if (base64Dp.isNotEmpty) {
      return CircleAvatar(
        backgroundImage: MemoryImage(base64Decode(base64Dp)),
        radius: context.dx(size / 2),
      );
    }

    return ClipOval(
      child: RemoteImage(
        iconData: Icons.person_3_outlined,
        iconSize: context.dx(size / 2),
        imageUrl: profileImage,
        size: context.dx(size),
      ),
    );
  }
}
