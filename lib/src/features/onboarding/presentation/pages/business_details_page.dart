import 'package:flutter/material.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_progress_indicator.dart';
import 'package:sme_fin/src/core/core.dart';

class BusinessDetailsPage extends StatefulWidget {
  const BusinessDetailsPage({super.key});

  @override
  State<BusinessDetailsPage> createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _businessNameController;
  late final TextEditingController _tradeLicenseController;

  @override
  void initState() {
    super.initState();
    _businessNameController = TextEditingController();
    _tradeLicenseController = TextEditingController();
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _tradeLicenseController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingProgressIndicator(
                  currentStep: 2,
                  totalSteps: 3,
                ),
                const SizedBox(height: 32),
                Text(
                  'Business Details',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tell us about your business',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Business Name',
                  hintText: 'Enter your business name',
                  controller: _businessNameController,
                  validator: (value) =>
                      Validators.validateRequired(value, 'Business name'),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Trade License Number',
                  hintText: 'Enter trade license number',
                  controller: _tradeLicenseController,
                  validator: (value) => Validators.validateRequired(
                    value,
                    'Trade license number',
                  ),
                ),
                const Spacer(),
                CustomButton(text: 'Next', onPressed: _next),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
