import 'package:go_router/go_router.dart';

import '../views/screens/auth/forgot_password_screen.dart';
import '../views/screens/auth/reset_password_screen.dart';
import '../views/screens/auth/sign_in_screen.dart';
import '../views/screens/auth/sign_up_screen.dart';
import '../views/screens/auth/verification_screen.dart';
import '../views/screens/dashboard/change_password_screen.dart';
import '../views/screens/dashboard/daily_quiz_intro_screen.dart';
import '../views/screens/dashboard/daily_quiz_screen.dart';
import '../views/screens/dashboard/dashboard_screen.dart';
import '../views/screens/dashboard/invite_friends_screen.dart';
import '../views/screens/dashboard/language_screen.dart';
import '../views/screens/dashboard/points_insight_screen.dart';
import '../views/screens/dashboard/profile_screen.dart';
import '../views/screens/dashboard/referral_team_screen.dart';
import '../views/screens/dashboard/rewards_screen.dart';
import '../views/screens/dashboard/steps_insight_screen.dart';
import '../views/screens/future/health_screen.dart';
import '../views/screens/future/marketplace_screen.dart';
import '../views/screens/future/meal_planner_screen.dart';
import '../views/screens/init/onboarding_screen.dart';
import '../views/screens/init/splash_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(builder: (_, __) => const SplashScreen(), path: '/'),
    GoRoute(
      path: '/dashboard',
      name: '$DashboardScreen',
      builder: (_, __) => const DashboardScreen(),
      routes: [
        GoRoute(
          path: 'rewards',
          name: '$RewardsScreen',
          builder: (_, __) => const RewardsScreen(),
          routes: [
            GoRoute(
              path: 'daily-quiz',
              name: '$DailyQuizIntroScreen',
              builder: (_, __) => const DailyQuizIntroScreen(),
              routes: [
                GoRoute(
                  builder: (_, __) => const DailyQuizScreen(),
                  name: '$DailyQuizScreen',
                  path: 'quiz',
                ),
              ],
            ),
            GoRoute(
              builder: (_, __) => const InviteFriendsScreen(),
              name: '$InviteFriendsScreen',
              path: 'invite-friends',
            ),
          ],
        ),
        GoRoute(
          builder: (_, __) => const ChangePasswordScreen(),
          name: '$ChangePasswordScreen',
          path: 'change-password',
        ),
        GoRoute(
          builder: (_, __) => const PointsInsightScreen(),
          name: '$PointsInsightScreen',
          path: 'points-insight',
        ),
        GoRoute(
          builder: (_, __) => const ReferralTeamScreen(),
          name: '$ReferralTeamScreen',
          path: 'referral-team',
        ),
        GoRoute(
          builder: (_, __) => const StepsInsightScreen(),
          name: '$StepsInsightScreen',
          path: 'steps-insight',
        ),
        GoRoute(
          builder: (_, __) => const MealPlannerScreen(),
          name: '$MealPlannerScreen',
          path: 'meal-planner',
        ),
        GoRoute(
          builder: (_, __) => const MarketplaceScreen(),
          name: '$MarketplaceScreen',
          path: 'marketplace',
        ),
        GoRoute(
          builder: (_, __) => const LanguageScreen(),
          name: '$LanguageScreen',
          path: 'language',
        ),
        GoRoute(
          builder: (_, __) => const ProfileScreen(),
          name: '$ProfileScreen',
          path: 'profile',
        ),
        GoRoute(
          builder: (_, __) => const HealthScreen(),
          name: '$HealthScreen',
          path: 'health',
        ),
      ],
    ),
    GoRoute(
      builder: (_, __) => const ForgotPasswordScreen(),
      name: '$ForgotPasswordScreen',
      path: '/forgot-password',
    ),
    GoRoute(
      builder: (_, __) => const ResetPasswordScreen(),
      name: '$ResetPasswordScreen',
      path: '/reset-password',
    ),
    GoRoute(
      builder: (_, __) => const VerificationScreen(),
      name: '$VerificationScreen',
      path: '/verification',
    ),
    GoRoute(
      builder: (_, __) => const OnboardingScreen(),
      name: '$OnboardingScreen',
      path: '/onboarding',
    ),
    GoRoute(
      builder: (_, __) => const SignInScreen(),
      name: '$SignInScreen',
      path: '/sign-in',
    ),
    GoRoute(
      builder: (_, __) => const SignUpScreen(),
      name: '$SignUpScreen',
      path: '/sign-up',
    ),
  ],
);
