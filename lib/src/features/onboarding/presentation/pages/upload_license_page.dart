import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_progress_indicator.dart';
import 'package:sme_fin/src/core/core.dart';

class UploadLicensePage extends StatefulWidget {
  const UploadLicensePage({super.key});

  @override
  State<UploadLicensePage> createState() => _UploadLicensePageState();
}

class _UploadLicensePageState extends State<UploadLicensePage> {
  String? _filePath;
  bool _isCompressing = false;

  Future<void> _pickFile() async {
    final result = await FilePickerService.pickFile();

    if (result != null) {
      final file = File(result.path!);

      // Compress if it's an image
      if (result.extension != 'pdf') {
        setState(() => _isCompressing = true);
        final compressed = await ImageCompressor.compressImage(file);
        setState(() => _isCompressing = false);

        if (compressed != null) {
          setState(() => _filePath = compressed.path);
        }
      } else {
        setState(() => _filePath = file.path);
      }
    }
  }

  void _next() {
    if (_filePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload your trade license')),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Trade License')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingProgressIndicator(currentStep: 3, totalSteps: 3),
              const SizedBox(height: 32),
              Text(
                'Upload Trade License',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Upload your business trade license document',
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 48),
              InkWell(
                onTap: _isCompressing ? null : _pickFile,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.outline,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: context.colorScheme.surfaceContainerHighest,
                  ),
                  child: _isCompressing
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Compressing image...'),
                            ],
                          ),
                        )
                      : _filePath != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 48,
                              color: context.colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _filePath!.split('/').last,
                              style: context.textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            TextButton.icon(
                              onPressed: _pickFile,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Change file'),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 48,
                              color: context.colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            const Text('Tap to upload'),
                            const SizedBox(height: 8),
                            Text(
                              'PDF, JPG, PNG (max 10MB)',
                              style: context.textTheme.bodySmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const Spacer(),
              CustomButton(text: 'Next', onPressed: _next),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
