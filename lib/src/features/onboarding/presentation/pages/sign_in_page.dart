import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_header_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendCode() {
    if (_formKey.currentState!.validate()) {
      context.read<OnboardingBloc>().add(
        SendVerificationCodeEvent(_emailController.text.trim()),
      );
    }
  }

  void _navigate(BuildContext context, OnboardingEntity data) {
    Log.debug('Data updated. ${data.step.name}');

    switch (data.step) {
      case OnboardingStep.signIn:
        context.go(AppRoutes.signIn);
        break;
      case OnboardingStep.verification:
        context.go(AppRoutes.verification, extra: data.email);
        break;
      case OnboardingStep.personalDetails:
        context.go(AppRoutes.personalDetails, extra: data);
        break;
      case OnboardingStep.businessDetails:
        context.go(AppRoutes.businessDetails, extra: data);
        break;
      case OnboardingStep.uploadLicense:
        context.go(AppRoutes.uploadLicense, extra: data);
        break;
      case OnboardingStep.confirmation:
        context.go(AppRoutes.confirmation, extra: data);
        break;
      case OnboardingStep.success:
        context.go(AppRoutes.success);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is VerificationCodeSent) {
            context.push(AppRoutes.verification, extra: state.email);
          } else if (state is OnboardingError) {
            SnackBarService.showError(
              state.message,
              actionLabel: 'Retry',
              onAction: _sendCode,
            );
          }
          if (state is OnboardingDataLoaded) {
            _navigate(
              context,
              state.data ??
                  OnboardingEntity(step: OnboardingStep.signIn, email: ''),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is OnboardingLoading;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OnboardingHeaderWidget(
                        title: 'Welcome to ${AppConstants.appName}',
                        subtitle: 'Enter your email to get started',
                      ),
                      const SizedBox(height: 48),
                      CustomTextField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: _emailController,
                        validator: Validators.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'Send Code',
                        onPressed: _sendCode,
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
