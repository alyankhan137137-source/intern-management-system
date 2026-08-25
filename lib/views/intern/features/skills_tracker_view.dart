import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class SkillsTrackerView extends StatelessWidget {
  const SkillsTrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = AppRepository().skills;

    return Scaffold(
      appBar: AppBar(title: const Text('Skills Radar')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your technical growth summary based on task completion and mentor feedback.', style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: AppSpacing.xl),
            ...skills.map((skill) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(skill.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('${(skill.level * 100).toInt()}%', style: TextStyle(color: skill.color, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: skill.level,
                    backgroundColor: Colors.grey[200],
                    color: skill.color,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
