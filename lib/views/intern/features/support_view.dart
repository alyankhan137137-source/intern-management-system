import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';

class SupportCenterView extends StatelessWidget {
  const SupportCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          const Text('Frequently Asked Questions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: AppSpacing.md),
          _buildFaqItem('How do I request leave?', 'Navigate to the Leave Management section in the side menu and click "Request Leave".'),
          _buildFaqItem('Where can I see my certificates?', 'All company certificates are stored in the Document Vault.'),
          _buildFaqItem('How to contact IT support?', 'Use the "Raise a Ticket" button below for technical assistance.'),
          const SizedBox(height: AppSpacing.xl),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.support_agent),
            label: const Text('Raise a Support Ticket'),
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 56)),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(answer, style: const TextStyle(color: AppColors.textSecondary)),
        ),
      ],
    );
  }
}
