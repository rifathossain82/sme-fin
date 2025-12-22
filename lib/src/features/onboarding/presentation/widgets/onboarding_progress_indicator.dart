import 'package:flutter/material.dart';
import 'package:sme_fin/src/core/core.dart';

class OnboardingProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const OnboardingProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  bool get _isFirstStep => currentStep == 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        totalSteps,
        (index) => Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _IndicatorLine(
                isActive: index < currentStep,
                isNotLastStep: index != totalSteps - 1,
              ),
              if (index == currentStep - 1)
                Positioned(
                  left: _isFirstStep ? 0 : null,
                  right: _isFirstStep ? null : 0,
                  top: -10,
                  child: _ActiveIndicatorCircle(currentStep: currentStep),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IndicatorLine extends StatelessWidget {
  final bool isActive;
  final bool isNotLastStep;

  const _IndicatorLine({required this.isActive, required this.isNotLastStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: isNotLastStep ? 8 : 0),
      height: 4,
      decoration: BoxDecoration(
        color: isActive
            ? context.colorScheme.primary
            : context.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class _ActiveIndicatorCircle extends StatelessWidget {
  final int currentStep;

  const _ActiveIndicatorCircle({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.primary,
      ),
      child: Center(
        child: Text(
          '$currentStep',
          style: TextStyle(
            color: context.colorScheme.onPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
