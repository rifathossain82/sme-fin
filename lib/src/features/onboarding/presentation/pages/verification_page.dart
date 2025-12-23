import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_state.dart';

class VerificationPage extends StatefulWidget {
  final String email;

  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 4) {
      context.read<OnboardingBloc>().add(VerifyCodeEvent(widget.email, code));
    }
  }

  void _resendCode() {
    context.read<OnboardingBloc>().add(SendVerificationCodeEvent(widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is CodeVerified) {
            /// Save email and navigate to personal details
            final entity = OnboardingEntity(email: widget.email);
            context.read<OnboardingBloc>().add(
              UpdateOnboardingDataEvent(entity),
            );
            context.push(AppRoutes.personalDetails, extra: entity);
          } else if (state is OnboardingError) {
            SnackBarService.showError(
              state.message,
              actionLabel: 'Retry',
              onAction: _verifyCode,
            );
          } else if (state is VerificationCodeSent) {
            SnackBarService.showSuccess('Code resent successfully');
          }
        },
        builder: (context, state) {
          final isLoading = state is OnboardingLoading;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Code',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We sent a verification code to ${widget.email}',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
                      (index) => SizedBox(
                        width: 64,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          enabled: !isLoading,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            } else if (value.isEmpty && index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                            if (index == 3 && value.isNotEmpty) {
                              _verifyCode();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: TextButton(
                      onPressed: isLoading ? null : _resendCode,
                      child: const Text('Resend code'),
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    text: 'Verify',
                    onPressed: _verifyCode,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
