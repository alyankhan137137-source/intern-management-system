import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class CareersBoardView extends StatelessWidget {
  const CareersBoardView({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = AppRepository().jobs;

    return Scaffold(
      appBar: AppBar(title: const Text('Internal Careers')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('${job.department} • ${job.type}', style: const TextStyle(color: AppColors.accent, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(job.description),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: () {}, child: const Text('Apply Now')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
