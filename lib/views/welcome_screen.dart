import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/views/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Hero Icon/Illustration Placeholder
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                ),
                child: const Icon(
                  Icons.business_center_rounded,
                  size: 60,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Intern Management System',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 36,
                      height: 1.1,
                      letterSpacing: -0.5,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Centralized lifecycle management for professional internship programs. Track progress, manage documentation, and empower your talent.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
              ),
              const Spacer(flex: 3),
              MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.identity()
                    ..translate(0.0, _isHovered ? -4.0 : 0.0),
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.buttonRadius,
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            )
                          ]
                        : [],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.buttonRadius,
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Learn more about IMS',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}
