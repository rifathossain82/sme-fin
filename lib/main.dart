import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/core/services/local_storage_service.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await LocalStorageService.init();

  // Initialize Navigation Manager
  NavigationManager.instance;

  // Initialize dependency injection
  await initializeDependencies();

  runApp(const SMEfinApp());
}

class SMEfinApp extends StatelessWidget {
  const SMEfinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OnboardingBloc>()..add(LoadSavedDataEvent()),
      child: MaterialApp.router(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: child!,
          );
        },
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerDelegate: NavigationManager.router.routerDelegate,
        routeInformationParser: NavigationManager.router.routeInformationParser,
        routeInformationProvider:
            NavigationManager.router.routeInformationProvider,
        scaffoldMessengerKey: sl.get<GlobalKey<ScaffoldMessengerState>>(),
      ),
    );
  }
}
