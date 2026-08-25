import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class AttendanceAnalyticsView extends StatelessWidget {
  const AttendanceAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    final history = AppRepository().attendanceHistory;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Program Attendance', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          _buildSummary(history),
          const SizedBox(height: AppSpacing.xl),
          Text('Daily Log Feed', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          ...history.map((log) => ListTile(
            leading: const Icon(Icons.person_pin, color: AppColors.accent),
            title: Text('Intern Check-in - ${log.location}'),
            subtitle: Text('${log.date.day}/${log.date.month} • ${log.totalHours.toStringAsFixed(1)} hours'),
            trailing: const Icon(Icons.check_circle, color: AppColors.success, size: 16),
          )),
        ],
      ),
    );
  }

  Widget _buildSummary(dynamic history) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.1),
        borderRadius: AppRadius.containerRadius,
        border: Border.all(color: AppColors.success.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: _Stat(label: 'Avg Hours', value: '7.5')),
          Expanded(child: _Stat(label: 'Present Today', value: '95%')),
          Expanded(child: _Stat(label: 'Late Check-ins', value: '2')),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.success)),
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }
}
