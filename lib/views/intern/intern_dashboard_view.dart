import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/models/user.dart';
import 'package:intern_management_system/models/task.dart';
import 'package:intern_management_system/services/app_repository.dart';

class InternDashboardView extends StatefulWidget {
  final UserModel user;
  const InternDashboardView({super.key, required this.user});

  @override
  State<InternDashboardView> createState() => _InternDashboardViewState();
}

class _InternDashboardViewState extends State<InternDashboardView> {
  final _repository = AppRepository();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          _buildProfileHeader(),
          const SizedBox(height: AppSpacing.xl),
          
          // Metrics Grid
          _buildMetricsGrid(),
          const SizedBox(height: AppSpacing.xl),

          // Milestone Roadmap
          Text(
            'Internship Journey',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildMilestoneRoadmap(),
          const SizedBox(height: AppSpacing.xl),

          // Skills Radar Summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Skills',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {
                  // Navigate to full radar view (already in drawer, but shortcut here)
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildSkillsSummary(),
          const SizedBox(height: AppSpacing.xl),
          
          // Feedback Section
          Text(
            'Mentor Feedback',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          ..._repository.feedback.take(2).map((f) => _buildFeedbackCard(f)),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Featured Task
          Text(
            'Next Priority',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildFeaturedTask(),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Achievement Badges
          Text(
            'Achievements',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildBadgesSection(),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: AppRadius.containerRadius,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white.withOpacity(0.1),
            child: Text(
              widget.user.name[0],
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${widget.user.name}',
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Keep up the great work!',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    final completion = _repository.taskCompletionRate;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.5,
      children: [
        _MetricCard(
          label: 'Completion',
          value: '${(completion * 100).toInt()}%',
          icon: Icons.pie_chart_outline_rounded,
          color: AppColors.accent,
        ),
        _MetricCard(
          label: 'Avg Rating',
          value: _repository.averageRating.toStringAsFixed(1),
          icon: Icons.star_outline_rounded,
          color: Colors.orange,
        ),
        _MetricCard(
          label: 'Pending',
          value: _repository.pendingTasksCount.toString(),
          icon: Icons.pending_actions_rounded,
          color: AppColors.error,
        ),
        _MetricCard(
          label: 'Days Logged',
          value: _repository.attendanceHistory.length.toString(),
          icon: Icons.calendar_today_rounded,
          color: AppColors.success,
        ),
      ],
    );
  }

  Widget _buildFeedbackCard(dynamic feedback) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(feedback.mentorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text(' ${feedback.rating}'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(feedback.comment, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedTask() {
    final task = _repository.tasks.firstWhere((t) => t.status != TaskStatus.completed);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.05),
        borderRadius: AppRadius.containerRadius,
        border: Border.all(color: AppColors.accent.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('HIGH PRIORITY', style: TextStyle(color: AppColors.error, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(task.description, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: AppSpacing.md),
          LinearProgressIndicator(
            value: 0.4,
            backgroundColor: Theme.of(context).dividerColor.withOpacity(0.1),
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildBadge(Icons.workspace_premium, 'Fast Learner', Colors.amber),
          _buildBadge(Icons.timer, 'Early Bird', Colors.green),
          _buildBadge(Icons.auto_awesome, 'UI Wizard', Colors.purple),
          _buildBadge(Icons.groups, 'Team Player', Colors.blue),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMilestoneRoadmap() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 100,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: AppRadius.containerRadius,
        border: Border.all(color: isDark ? AppColors.darkBorder : const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMilestone('Start', true),
          _buildConnector(true),
          _buildMilestone('Mid-term', true),
          _buildConnector(false),
          _buildMilestone('Final', false),
        ],
      ),
    );
  }

  Widget _buildMilestone(String label, bool isCompleted) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? AppColors.success : (isDark ? AppColors.textSecondaryDark : Colors.grey),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 10, color: isCompleted ? (isDark ? Colors.white : AppColors.textPrimary) : Colors.grey)),
      ],
    );
  }

  Widget _buildConnector(bool isActive) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? AppColors.success : (isDark ? AppColors.darkBorder : Colors.grey[200]),
        margin: const EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget _buildSkillsSummary() {
    return Row(
      children: _repository.skills.take(3).map((skill) {
        return Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: skill.color.withOpacity(0.1),
              borderRadius: AppRadius.cardRadius,
            ),
            child: Column(
              children: [
                Text(skill.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(
                    value: skill.level,
                    strokeWidth: 4,
                    color: skill.color,
                    backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: AppRadius.cardRadius,
        border: Border.all(color: isDark ? AppColors.darkBorder : const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary, fontSize: 12)),
        ],
      ),
    );
  }
}
