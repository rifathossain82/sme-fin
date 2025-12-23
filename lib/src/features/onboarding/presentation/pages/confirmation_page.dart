import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/core/core.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_header_widget.dart';

class ConfirmationPage extends StatelessWidget {
  final OnboardingEntity data;

  const ConfirmationPage({super.key, required this.data});

  void _submit(BuildContext context) {
    context.read<OnboardingBloc>().add(SubmitOnboardingDataEvent(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmation')),
      body: BlocConsumer<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingSubmissionSuccess) {
            context.go(AppRoutes.success);
          } else if (state is OnboardingError) {
            SnackBarService.showError(
              state.message,
              actionLabel: 'Retry',
              onAction: () => _submit(context),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is OnboardingLoading;

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OnboardingHeaderWidget(
                      title: 'Summary',
                      subtitle: 'Please review your information',
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InfoCard(
                          title: 'Personal Info',
                          children: [
                            _InfoItem(
                              label: 'Full Name',
                              value: data.fullName ?? 'N/A',
                            ),
                            _InfoItem(label: 'Email', value: data.email),
                            _InfoItem(
                              label: 'Phone Number',
                              value: data.phoneNumber ?? 'N/A',
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _InfoCard(
                          title: 'Business Info',
                          children: [
                            _InfoItem(
                              label: 'Business Name',
                              value: data.businessName ?? 'N/A',
                            ),
                            _InfoItem(
                              label: 'Trade License Number',
                              value: data.tradeLicenseNumber ?? 'N/A',
                            ),
                            _InfoItem(
                              label: 'License File',
                              value:
                                  data.tradeLicensePath?.split('/').last ??
                                  'N/A',
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      text: 'Submit',
                      onPressed: isLoading ? null : () => _submit(context),
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: 16),
                    const Center(child: _DataStoredStatusCard()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        border: Border.all(color: context.colorScheme.outline),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String label;
  final String value;

  const _InfoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}

class _DataStoredStatusCard extends StatelessWidget {
  const _DataStoredStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: context.colorScheme.primary),
          const SizedBox(width: 12),
          Text('Data stored securely', style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
