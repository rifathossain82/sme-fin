import 'package:flutter/material.dart';
import 'package:sme_fin/src/core/core.dart';

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
      Log.debug('Code: $code');
    }
  }

  void _resendCode() {}

  @override
  Widget build(BuildContext context) {
    var isLoading = false;

    return Scaffold(
      appBar: AppBar(title: const Text('Verification')),
      body: SafeArea(
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
      ),
    );
  }
}
