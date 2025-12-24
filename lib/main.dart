import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/core/services/local_storage_service.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const SMEfinApp());
}

Future<void> initApp() async {
  try {
    await LocalStorageService.init();
    await initializeDependencies();
    await sl<NavigationManager>().init();
  } catch (e, s) {
    Log.error('Error initializing app: $e\n', stackTrace: s);
    rethrow;
  }
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
        routerConfig: sl<NavigationManager>().router,
        scaffoldMessengerKey: sl<GlobalKey<ScaffoldMessengerState>>(),
      ),
    );
  }
}
