import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/business_details_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/confirmation_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/personal_details_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/sign_in_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/success_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/upload_license_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/verification_page.dart';

import 'app_routes.dart';

class NavigationManager {
  static final NavigationManager _instance = NavigationManager._internal();

  static NavigationManager get instance => _instance;

  static late final GoRouter router;

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  factory NavigationManager() {
    return _instance;
  }

  NavigationManager._internal() {
    final routes = [
      GoRoute(
        path: AppRoutes.signIn,
        pageBuilder: (context, state) =>
            getPage(child: const SignInPage(), state: state),
      ),
      GoRoute(
        path: AppRoutes.verification,
        pageBuilder: (context, state) {
          final email = state.extra as String;

          return getPage(
            child: VerificationPage(email: email),
            state: state,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.personalDetails,
        pageBuilder: (context, state) {
          final data = state.extra as OnboardingEntity;
          return getPage(
            child: PersonalDetailsPage(data: data),
            state: state,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.businessDetails,
        pageBuilder: (context, state) {
          final data = state.extra as OnboardingEntity;
          return getPage(
            child: BusinessDetailsPage(data: data),
            state: state,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.uploadLicense,
        pageBuilder: (context, state) {
          final data = state.extra as OnboardingEntity;
          return getPage(
            child: UploadLicensePage(data: data),
            state: state,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.confirmation,
        pageBuilder: (context, state) {
          return getPage(child: const ConfirmationPage(), state: state);
        },
      ),
      GoRoute(
        path: AppRoutes.success,
        pageBuilder: (context, state) {
          return getPage(child: const SuccessPage(), state: state);
        },
      ),
    ];

    router = GoRouter(initialLocation: AppRoutes.signIn, routes: routes);
  }

  static Page getPage({required Widget child, required GoRouterState state}) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}
