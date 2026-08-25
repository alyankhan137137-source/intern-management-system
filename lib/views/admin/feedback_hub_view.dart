import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class FeedbackHubView extends StatelessWidget {
  const FeedbackHubView({super.key});

  @override
  Widget build(BuildContext context) {
    final feedback = AppRepository().feedback;
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: feedback.length,
      itemBuilder: (context, index) {
        final f = feedback[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppSpacing.md),
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.rate_review)),
            title: Text('Mentor: ${f.mentorName}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(f.comment),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                Text(' ${f.rating}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
