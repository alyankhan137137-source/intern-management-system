import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';
import 'package:intern_management_system/models/enterprise_models.dart';
import 'package:intern_management_system/widgets/skeleton_loader.dart';

class AdminDashboardView extends StatefulWidget {
  const AdminDashboardView({super.key});

  @override
  State<AdminDashboardView> createState() => _AdminDashboardViewState();
}

class _AdminDashboardViewState extends State<AdminDashboardView> {
  final _repository = AppRepository();
  final _announcementController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() => _isLoading = false);
  }

  void _postAnnouncement() {
    if (_announcementController.text.trim().isEmpty) return;
    setState(() {
      _repository.postAnnouncement(AnnouncementModel(
        id: DateTime.now().toString(),
        title: 'Admin Broadcast',
        message: _announcementController.text.trim(),
        date: DateTime.now(),
        isPriority: true,
      ));
      _announcementController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Announcement posted successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SkeletonList();
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Program Analytics', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          _buildAnalyticsGrid(),
          const SizedBox(height: AppSpacing.xl),
          
          Text('Post Announcement', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          _buildAnnouncementPoster(),
          const SizedBox(height: AppSpacing.xl),
          
          Text('Recent Announcements', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          ..._repository.announcements.take(3).map((a) => _buildAnnouncementCard(a)),
        ],
      ),
    );
  }

  Widget _buildAnalyticsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.6,
      children: [
        _AnalyticsCard(label: 'Total Interns', value: _repository.interns.length.toString(), color: AppColors.accent),
        _AnalyticsCard(label: 'Completion Rate', value: '${(_repository.taskCompletionRate * 100).toInt()}%', color: AppColors.success),
        _AnalyticsCard(label: 'Pending Leaves', value: _repository.leaves.where((l) => l.status == LeaveStatus.pending).length.toString(), color: Colors.orange),
        _AnalyticsCard(label: 'Avg Performance', value: _repository.averageRating.toStringAsFixed(1), color: Colors.purple),
      ],
    );
  }

  Widget _buildAnnouncementPoster() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            TextField(
              controller: _announcementController,
              decoration: const InputDecoration(
                hintText: 'Type announcement here...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _postAnnouncement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Broadcast to Interns'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(AnnouncementModel a) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        leading: Icon(Icons.campaign, color: a.isPriority ? AppColors.error : AppColors.accent),
        title: Text(a.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(a.message),
        trailing: Text('${a.date.day}/${a.date.month}', style: const TextStyle(fontSize: 10)),
      ),
    );
  }
}

class _AnalyticsCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _AnalyticsCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.cardRadius,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }
}
