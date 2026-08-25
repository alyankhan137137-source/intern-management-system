import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class AuditLogView extends StatelessWidget {
  const AuditLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = AppRepository().auditLogs;

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return ListTile(
          leading: const Icon(Icons.history_edu, color: AppColors.accent),
          title: Text(log.action, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('By ${log.adminName} • ${log.timestamp.hour}:${log.timestamp.minute}'),
          trailing: Text('${log.timestamp.day}/${log.timestamp.month}', style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
        );
      },
    );
  }
}
