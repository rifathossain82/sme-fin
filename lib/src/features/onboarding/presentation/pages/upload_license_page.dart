import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/features/onboarding/domain/entities/onboarding_entity.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:sme_fin/src/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_header_widget.dart';
import 'package:sme_fin/src/features/onboarding/presentation/widgets/onboarding_progress_indicator.dart';
import 'package:sme_fin/src/core/core.dart';

class UploadLicensePage extends StatefulWidget {
  final OnboardingEntity data;

  const UploadLicensePage({super.key, required this.data});

  @override
  State<UploadLicensePage> createState() => _UploadLicensePageState();
}

class _UploadLicensePageState extends State<UploadLicensePage> {
  String? _filePath;
  bool _isCompressing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _loadInitialData();
    });
  }

  void _loadInitialData(){
    _filePath = widget.data.tradeLicensePath;
    setState(() {});
  }

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

  void _clearFile() {
    setState(() => _filePath = null);
  }

  void _next() {
    if (_filePath == null) {
      SnackBarService.showError('Please upload your trade license');
      return;
    }

    final updatedData = widget.data.copyWith(
      step: OnboardingStep.uploadLicense,
      tradeLicensePath: _filePath,
    );
    context.read<OnboardingBloc>().add(UpdateOnboardingDataEvent(updatedData));
    context.push(AppRoutes.confirmation, extra: updatedData);
  }

  String get fileName => FilePickerService.getFileName(File(_filePath!))!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Trade License')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const OnboardingProgressIndicator(
                  currentStep: 3,
                  totalSteps: 3,
                ),
                const SizedBox(height: 32),
                const OnboardingHeaderWidget(
                  title: 'Upload Trade License',
                  subtitle: 'Upload your business trade license document',
                ),
                const SizedBox(height: 48),
                _FilePickerCard(
                  isCompressing: _isCompressing,
                  onPickFile: _pickFile,
                  filePath: _filePath,
                ),

                const SizedBox(height: 20),
                if (_filePath != null)
                  _SingleFileCard(fileName: fileName, onClearFile: _clearFile),
                const SizedBox(height: 24),
                CustomButton(text: 'Next', onPressed: _next),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FilePickerCard extends StatelessWidget {
  final bool isCompressing;
  final VoidCallback onPickFile;
  final String? filePath;

  const _FilePickerCard({
    required this.isCompressing,
    required this.onPickFile,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isCompressing ? null : onPickFile,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: context.colorScheme.surfaceContainerHighest,
        ),
        child: Center(
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              dashPattern: [10, 5],
              strokeWidth: 2,
              radius: Radius.circular(8.0),
              color: context.colorScheme.outline,
              stackFit: StackFit.expand,
            ),
            child: isCompressing
                ? const _ImageCompressingLoaderView()
                : filePath != null
                ? const _TapToReplaceView()
                : const _TapToUploadView(),
          ),
        ),
      ),
    );
  }
}

class _ImageCompressingLoaderView extends StatelessWidget {
  const _ImageCompressingLoaderView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Compressing image...'),
        ],
      ),
    );
  }
}

class _TapToReplaceView extends StatelessWidget {
  const _TapToReplaceView();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.replay, size: 48, color: context.colorScheme.primary),
        const SizedBox(height: 16),
        const Text('Tap to replace'),
        const SizedBox(height: 8),
        Text(
          'PDF, JPG, PNG (max 10MB)',
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _TapToUploadView extends StatelessWidget {
  const _TapToUploadView();

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class _SingleFileCard extends StatelessWidget {
  final String fileName;
  final VoidCallback onClearFile;

  const _SingleFileCard({required this.fileName, required this.onClearFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.outline,
          style: BorderStyle.solid,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.surfaceContainerHighest,
      ),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file_rounded,
            color: context.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Text(
            fileName,
            style: context.textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          IconButton(onPressed: onClearFile, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
