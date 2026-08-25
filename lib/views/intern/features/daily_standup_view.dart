import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';

class DailyStandupView extends StatefulWidget {
  const DailyStandupView({super.key});

  @override
  State<DailyStandupView> createState() => _DailyStandupViewState();
}

class _DailyStandupViewState extends State<DailyStandupView> {
  final _achievementsController = TextEditingController();
  final _blockersController = TextEditingController();

  void _submitStandup() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Daily Standup submitted successfully!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Standup')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Achievements', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(controller: _achievementsController, maxLines: 4, decoration: const InputDecoration(hintText: 'What did you accomplish today?', border: OutlineInputBorder())),
            const SizedBox(height: AppSpacing.lg),
            const Text('Blockers', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(controller: _blockersController, maxLines: 2, decoration: const InputDecoration(hintText: 'Any challenges holding you back?', border: OutlineInputBorder())),
            const SizedBox(height: AppSpacing.xxl),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(onPressed: _submitStandup, child: const Text('Submit Journal')),
            ),
          ],
        ),
      ),
    );
  }
}
