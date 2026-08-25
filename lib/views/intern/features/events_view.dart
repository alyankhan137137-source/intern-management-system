import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class EventsView extends StatelessWidget {
  const EventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final events = AppRepository().events;

    return Scaffold(
      appBar: AppBar(title: const Text('Events & Workshops')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(event.icon, color: AppColors.accent),
                      const SizedBox(width: 8),
                      Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Time: ${event.time} • Date: ${event.date}', style: const TextStyle(color: AppColors.textSecondary)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Join Session'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
