import 'package:flutter/material.dart';
import 'package:sme_fin/src/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MaterialApp.router(
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
    );
  }
}
