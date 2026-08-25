import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = AppRepository();
    final notifications = repository.notifications;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final note = notifications[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: AppColors.accent.withOpacity(0.1),
              child: const Icon(Icons.notifications_active_outlined, color: AppColors.accent, size: 20),
            ),
            title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.message),
                const SizedBox(height: 4),
                Text(
                  '${note.timestamp.hour}:${note.timestamp.minute}',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
