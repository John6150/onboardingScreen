import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboardingscreen/dashboard.dart';
import 'package:onboardingscreen/main.dart';
import 'package:onboardingscreen/onboardingScreen.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const MyHomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'onboarding',
          builder: (BuildContext context, GoRouterState state) {
            return OnBoardingScreen();
          },
        ),
        GoRoute(
          path: '/dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return DashBoard();
          },
        ),
      ],
    ),
  ],
);
