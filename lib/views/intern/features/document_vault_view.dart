import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';

class DocumentVaultView extends StatelessWidget {
  const DocumentVaultView({super.key});

  @override
  Widget build(BuildContext context) {
    final docs = AppRepository().documents;

    return Scaffold(
      appBar: AppBar(title: const Text('Document Vault')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: docs.length,
        itemBuilder: (context, index) {
          final doc = docs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: ListTile(
              leading: const Icon(Icons.description, color: AppColors.accent),
              title: Text(doc.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Type: ${doc.type} • Expiry: ${doc.expiryDate}'),
              trailing: IconButton(icon: const Icon(Icons.download), onPressed: () {}),
            ),
          );
        },
      ),
    );
  }
}
