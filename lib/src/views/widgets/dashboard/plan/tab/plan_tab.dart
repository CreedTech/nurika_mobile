import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../gen/colors.gen.dart';
import '../../../../../core/constants.dart';
import '../../../../../core/extensions.dart';
import '../../../../screens/future/health_screen.dart';
import '../../../../screens/future/marketplace_screen.dart';
import '../../../../screens/future/meal_planner_screen.dart';
import '../../../common/raised_container.dart';
import '../../../common/space.dart';

class PlanTab extends StatelessWidget {
  const PlanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = context.l10n;

    final imageAssets = [
      Assets.images.cardiogram,
      Assets.images.planning,
      Assets.images.marketplace,
    ];

    final destinations = [
      '$HealthScreen',
      '$MealPlannerScreen',
      '$MarketplaceScreen',
    ];

    final descriptions = [
      localizations.takeProactiveApproach,
      localizations.nurikaProvidesYou,
      localizations.useYourRewards,
    ];

    final titles = [
      localizations.health,
      localizations.personalizedMealPlanner,
      localizations.marketplace,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.dy(24.0)),
      child: Column(
        children: [
          Text(
            localizations.plan,
            style: context.textStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
          const Space.vertical(24.0),
          ListView.separated(
            physics: unscrollableScrollPhysics,
            separatorBuilder: (_, __) => const Space.vertical(24.0),
            itemBuilder: (context, index) => RaisedContainer(
              onTap: () => context.pushNamed(destinations[index]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageAssets[index].image(
                    height: context.dx(42.0),
                    width: context.dx(42.0),
                    fit: BoxFit.cover,
                  ),
                  const Space.vertical(16.0),
                  Text(
                    titles[index],
                    style: context.textStyle(
                      colour: const Color(0xFF131F03),
                      fontWeight: FontWeight.w600,
                      fontSize: 22.0,
                    ),
                  ),
                  const Space.vertical(8.0),
                  Text(
                    descriptions[index],
                    style: context.textStyle(
                      colour: ColorName.darkJungleGreen,
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            itemCount: titles.length,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }
}
