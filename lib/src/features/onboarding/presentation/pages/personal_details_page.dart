import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_header_widget.dart';

import '../widgets/onboarding_progress_indicator.dart';

class PersonalDetailsPage extends StatefulWidget {
  final OnboardingEntity data;

  const PersonalDetailsPage({super.key, required this.data});

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.data.fullName);
    _emailController = TextEditingController(text: widget.data.email);
    _phoneController = TextEditingController(text: widget.data.phoneNumber);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _next() {
    if (_formKey.currentState!.validate()) {
      final updatedData = widget.data.copyWith(
        step: OnboardingStep.personalDetails,
        fullName: _fullNameController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
      );
      context.read<OnboardingBloc>().add(
        UpdateOnboardingDataEvent(updatedData),
      );
      context.push(AppRoutes.businessDetails, extra: updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Details')),
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
                    currentStep: 1,
                    totalSteps: 3,
                  ),
                  const SizedBox(height: 32),
                  const OnboardingHeaderWidget(
                    title: 'Personal Details',
                    subtitle: 'Tell us about yourself',
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Full Name',
                    hintText: 'Enter your full name',
                    controller: _fullNameController,
                    validator: (value) =>
                        Validators.validateRequired(value, 'Full name'),
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Email',
                    controller: _emailController,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Phone Number',
                    hintText: 'Enter your phone number',
                    controller: _phoneController,
                    validator: Validators.validatePhone,
                    keyboardType: TextInputType.phone,
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
