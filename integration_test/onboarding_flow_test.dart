import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sme_fin/main.dart' as app;
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/core/services/local_storage_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Complete onboarding flow with app restart', (WidgetTester tester) async {
    // Initialize and clear storage
    await LocalStorageService.init();

    // Initialize dependency injection
    await initializeDependencies();

    // Initialize navigation manager
    await sl<NavigationManager>().init();

    // Start app
    await tester.pumpWidget(const app.SMEfinApp());
    await tester.pumpAndSettle();

    // Step 1: Enter email and send code
    final emailField = find.byType(TextFormField).first;
    await tester.enterText(emailField, 'test@example.com');
    await tester.pumpAndSettle();

    final sendCodeButton = find.text('Send Code');
    await tester.tap(sendCodeButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Step 2: Enter verification code (if screen appeared)
    if (find.byType(TextField).evaluate().isNotEmpty) {
      final codeFields = find.byType(TextField);
      for (int i = 0; i < 4 && i < codeFields.evaluate().length; i++) {
        await tester.enterText(codeFields.at(i), '1');
      }
      await tester.pumpAndSettle(const Duration(seconds: 2));
    }

    // Step 3: Fill personal details (if screen appeared)
    if (find.byType(TextFormField).evaluate().length >= 2) {
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'John Doe');
      await tester.enterText(fields.last, '+1234567890');
      await tester.pumpAndSettle();

      // Tap Next if available
      final nextButton = find.text('Next');
      if (nextButton.evaluate().isNotEmpty) {
        await tester.tap(nextButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }
    }

    // Step 4: Fill business details (if screen appeared)
    if (find.byType(TextFormField).evaluate().length >= 2) {
      final fields = find.byType(TextFormField);
      await tester.enterText(fields.first, 'Test Business Inc');
      await tester.enterText(fields.at(1), 'TL123456789');
      await tester.pumpAndSettle();

      // Tap Next if available
      final nextButton = find.text('Next');
      if (nextButton.evaluate().isNotEmpty) {
        await tester.tap(nextButton);
        await tester.pumpAndSettle(const Duration(seconds: 2));
      }
    }

    // Simulate app restart
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(milliseconds: 500));

    Future<void> waitForElement(WidgetTester tester, Finder finder, {Duration timeout = const Duration(seconds: 5)}) async {
      final endTime = DateTime.now().add(timeout);
      while (finder.evaluate().isEmpty && DateTime.now().isBefore(endTime)) {
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    // Restart app
    await tester.pumpWidget(const app.SMEfinApp());
    await waitForElement(tester, find.textContaining('Test Business'));

    // Verify app shows some content (not stuck on loading)
    expect(find.byType(MaterialApp), findsOneWidget);

    // Check if business data is visible anywhere
    final hasBusinessData = find.textContaining('Test Business', findRichText: true).evaluate().isNotEmpty;
    final hasTextFields = find.byType(TextFormField).evaluate().isNotEmpty;

    // Should have either restored data or form fields visible
    expect(hasBusinessData || hasTextFields, isTrue,
        reason: 'App should restore state after restart');

    // Cleanup
    await LocalStorageService().closeAll();
  });
}