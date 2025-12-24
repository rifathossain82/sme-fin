import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/business_details_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/confirmation_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/personal_details_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/sign_in_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/success_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/upload_license_page.dart';
import 'package:sme_fin/src/features/onboarding/presentation/pages/verification_page.dart';

class NavigationManager {
  late final GoRouter _router;

  GoRouter get router => _router;

  BuildContext get context =>
      _router.routerDelegate.navigatorKey.currentContext!;

  Future<void> init() async {
    _router = GoRouter(initialLocation: AppRoutes.signIn, routes: _routes);
  }

  List<GoRoute> get _routes => [
    GoRoute(
      path: AppRoutes.signIn,
      pageBuilder: (context, state) => _page(const SignInPage(), state),
    ),
    GoRoute(
      path: AppRoutes.verification,
      pageBuilder: (context, state) {
        final email = state.extra as String;
        return _page(VerificationPage(email: email), state);
      },
    ),
    GoRoute(
      path: AppRoutes.personalDetails,
      pageBuilder: (context, state) {
        final data = state.extra as OnboardingEntity?;
        if (data == null) return _page(const SignInPage(), state);
        return _page(PersonalDetailsPage(data: data), state);
      },
    ),
    GoRoute(
      path: AppRoutes.businessDetails,
      pageBuilder: (context, state) {
        final data = state.extra as OnboardingEntity?;
        if (data == null) return _page(const SignInPage(), state);
        return _page(BusinessDetailsPage(data: data), state);
      },
    ),
    GoRoute(
      path: AppRoutes.uploadLicense,
      pageBuilder: (context, state) {
        final data = state.extra as OnboardingEntity?;
        if (data == null) return _page(const SignInPage(), state);
        return _page(UploadLicensePage(data: data), state);
      },
    ),
    GoRoute(
      path: AppRoutes.confirmation,
      pageBuilder: (context, state) {
        final data = state.extra as OnboardingEntity?;
        if (data == null) return _page(const SignInPage(), state);
        return _page(ConfirmationPage(data: data), state);
      },
    ),
    GoRoute(
      path: AppRoutes.success,
      pageBuilder: (context, state) => _page(const SuccessPage(), state),
    ),
  ];

  static Page _page(Widget child, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}
