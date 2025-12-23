import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_header_widget.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_progress_indicator.dart';
import 'package:sme_fin/src/core/core.dart';

class BusinessDetailsPage extends StatefulWidget {
  final OnboardingEntity data;

  const BusinessDetailsPage({super.key, required this.data});

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
    _businessNameController = TextEditingController(
      text: widget.data.businessName,
    );
    _tradeLicenseController = TextEditingController(
      text: widget.data.tradeLicenseNumber,
    );
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _tradeLicenseController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      final updatedData = widget.data.copyWith(
        step: OnboardingStep.businessDetails,
        businessName: _businessNameController.text.trim(),
        tradeLicenseNumber: _tradeLicenseController.text.trim(),
      );
      context.read<OnboardingBloc>().add(
        UpdateOnboardingDataEvent(updatedData),
      );
      context.push(AppRoutes.uploadLicense, extra: updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Business Details')),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  const OnboardingHeaderWidget(
                    title: 'Business Details',
                    subtitle: 'Tell us about your business',
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
                  const SizedBox(height: 24),
                  CustomButton(text: 'Next', onPressed: _next),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
