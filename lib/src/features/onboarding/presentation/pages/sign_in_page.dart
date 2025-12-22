import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sme_fin/src/core/core.dart';

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
      context.push(AppRoutes.verification, extra: _emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Text(
                  'Welcome to ${AppConstants.appName}',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email to get started',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 48),
                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter your email',
                  controller: _emailController,
                  validator: Validators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  enabled: true,
                ),
                const Spacer(),
                CustomButton(
                  text: 'Send Code',
                  onPressed: _sendCode,
                  isLoading: false,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
