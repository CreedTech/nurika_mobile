import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/extensions.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../dashboard/dashboard_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.read(authViewModel);

    return AnnotatedScaffold(
      tint: ColorName.oceanGreen,
      body: Center(
        child: Assets.images.banner
            .image(width: context.dx(240.0))
            .animate(delay: 512.milliseconds)
            .scale(
              begin: const Offset(0.512, 0.512),
              duration: 1024.milliseconds,
              curve: Curves.bounceOut,
            )
            .callback(
              callback: (_) => context.goNamed(
                authState.accessToken.isEmpty ||
                        authState.currentUser.firstName.isEmpty
                    ? '$OnboardingScreen'
                    : '$DashboardScreen',
              ),
            ),
      ),
    );
  }
}
