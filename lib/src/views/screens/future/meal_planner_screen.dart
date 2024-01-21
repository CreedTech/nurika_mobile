import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/extensions.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/space.dart';
import '../../widgets/common/svg_button.dart';
import '../../widgets/dashboard/plan/future/coming_soon_board.dart';

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    return AnnotatedScaffold(
      tint: const Color(0xFFD1FFE5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.dx(24.0),
            vertical: context.dy(40.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.graphics.progressBar.svg(
                width: context.dx(380.0),
                height: context.dy(4.0),
                fit: BoxFit.cover,
              ),
              const Space.vertical(28.0),
              SvgButton(
                svgAsset: Assets.graphics.close,
                height: context.dx(24.0),
                width: context.dx(24.0),
                onTap: context.pop,
              ),
              const Space.vertical(24.0),
              Text(
                localizations.personalizedMealPlanner,
                style: context.textStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28.0,
                ),
              ),
              const Space.vertical(14.0),
              Text(
                '${localizations.nurikaProvidesYou}\n\n'
                '${localizations.noMoreGuessing}',
                style: context.textStyle(
                  colour: ColorName.outerSpace,
                  fontSize: 16.5,
                ),
              ),
              const Spacer(),
              Center(
                child: Assets.graphics.healthyFoods.svg(
                  height: context.dy(334.0),
                  width: context.dx(336.0),
                  fit: BoxFit.cover,
                ),
              ),
              const Space.vertical(32.0),
              const ComingSoonBoard(),
              const Space.vertical(16.0),
            ],
          ),
        ),
      ),
    );
  }
}
