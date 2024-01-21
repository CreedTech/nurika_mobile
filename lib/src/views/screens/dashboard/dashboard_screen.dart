import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../core/constants.dart';
import '../../../core/extensions.dart';
import '../../../services/interfaces/notifier_service.dart';
import '../../../viewmodels/auth/auth_view_model.dart';
import '../../../viewmodels/dashboard/dashboard_view_model.dart';
import '../../widgets/common/annotated_scaffold.dart';
import '../../widgets/common/clickable.dart';
import '../../widgets/common/space.dart';
import '../../widgets/dashboard/home/tab/home_tab.dart';
import '../../widgets/dashboard/leaderboard/tab/leaderboard_tab.dart';
import '../../widgets/dashboard/plan/tab/plan_tab.dart';
import '../../widgets/dashboard/settings/tab/settings_tab.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late final _localizations = context.l10n;

  late final _tabIcons = [
    Assets.graphics.home,
    Assets.graphics.crown,
    Assets.graphics.note,
    Assets.graphics.settings,
  ];

  late final _tabNames = [
    _localizations.home,
    _localizations.leaderboard,
    _localizations.plan,
    _localizations.settings,
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardViewModel.notifier).tuneInToBackgroundService();
      ref.read(authViewModel.notifier).fetchCurrentUserData();
    });

    notifier.listen((payload) {
      switch (payload) {
        case motivationalNotificationPayload:
          break;

        case stepCountNotificationPayload:
          break;

        case hydrationNotificationPayload:
          break;

        case reminderNotificationPayload:
          break;

        case congratsNotificationPayload:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentTabIndex = ref.watch(
      dashboardViewModel.select((state) => state.tabIndex),
    );

    return AnnotatedScaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: IndexedStack(
                index: currentTabIndex,
                sizing: StackFit.expand,
                children: const [
                  HomeTab(),
                  LeaderboardTab(),
                  PlanTab(),
                  SettingsTab(),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.dx(32.0),
                vertical: context.dy(16.0),
              ),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: ColorName.brightGrey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final (index, tabName) in _tabNames.indexed)
                    Clickable(
                      onClick: () => ref
                          .read(dashboardViewModel.notifier)
                          .update(tabIndex: index),
                      child: Column(
                        children: [
                          _tabIcons[index].svg(
                            width: context.dx(24.0),
                            height: context.dx(24.0),
                            colorFilter: currentTabIndex == index
                                ? const ColorFilter.mode(
                                    ColorName.oceanGreen,
                                    BlendMode.srcIn,
                                  )
                                : null,
                          ),
                          const Space.vertical(2.0),
                          Text(
                            tabName,
                            style: context.textStyle(
                              colour: currentTabIndex != index
                                  ? const Color(0xFFA7AFBD)
                                  : ColorName.oceanGreen,
                              fontWeight: currentTabIndex != index
                                  ? FontWeight.normal
                                  : FontWeight.w500,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
