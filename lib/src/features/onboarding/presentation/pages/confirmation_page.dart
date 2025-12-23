import 'package:flutter/material.dart';
import 'package:sme_fin/src/core/core.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  void _submit(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    return Scaffold(
      appBar: AppBar(title: const Text('Confirmation')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Summary',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoCard(
                        title: 'Personal Info',
                        children: [
                          _InfoItem(label: 'Full Name', value: 'Jamal Hossain'),
                          _InfoItem(label: 'Email', value: 'jamal@gmail.com'),
                          _InfoItem(
                            label: 'Phone Number',
                            value: '01885256220',
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _InfoCard(
                        title: 'Business Info',
                        children: [
                          _InfoItem(
                            label: 'Business Name',
                            value: 'Test Business',
                          ),
                          _InfoItem(
                            label: 'Trade License Number',
                            value: '6465454',
                          ),
                          _InfoItem(label: 'License File', value: 'N/A'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Submit',
                onPressed: isLoading ? null : () => _submit(context),
                isLoading: isLoading,
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Data stored securely',
                  style: context.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
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
