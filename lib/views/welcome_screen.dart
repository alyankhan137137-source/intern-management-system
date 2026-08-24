import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                'Streamline your\ninternship program.',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 32,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'A professional platform to manage, track, and empower your future talent.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: AppRadius.buttonRadius,
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
