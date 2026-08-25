import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/models/task.dart';
import 'package:intern_management_system/services/app_repository.dart';

class TaskTrackerView extends StatefulWidget {
  const TaskTrackerView({super.key});

  @override
  State<TaskTrackerView> createState() => _TaskTrackerViewState();
}

class _TaskTrackerViewState extends State<TaskTrackerView> {
  final _repository = AppRepository();
  String _searchQuery = '';
  TaskStatus? _filterStatus;

  @override
  Widget build(BuildContext context) {
    final filteredTasks = _repository.tasks.where((task) {
      final matchesSearch = task.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _filterStatus == null || task.status == _filterStatus;
      return matchesSearch && matchesFilter;
    }).toList();

    return Column(
      children: [
        // Search & Filter Header
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark 
                      ? AppColors.darkSurface 
                      : Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.buttonRadius,
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: _filterStatus == null,
                      onTap: () => setState(() => _filterStatus = null),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _FilterChip(
                      label: 'To Do',
                      isSelected: _filterStatus == TaskStatus.todo,
                      onTap: () => setState(() => _filterStatus = TaskStatus.todo),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _FilterChip(
                      label: 'In Progress',
                      isSelected: _filterStatus == TaskStatus.inProgress,
                      onTap: () => setState(() => _filterStatus = TaskStatus.inProgress),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    _FilterChip(
                      label: 'Completed',
                      isSelected: _filterStatus == TaskStatus.completed,
                      onTap: () => setState(() => _filterStatus = TaskStatus.completed),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Task List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return _TaskListItem(
                task: task,
                onStatusChanged: (newStatus) {
                  setState(() {
                    _repository.updateTaskStatus(task.id, newStatus);
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : (isDark ? AppColors.darkSurface : Colors.white),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.accent : (isDark ? AppColors.darkBorder : Colors.grey[300]!)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _TaskListItem extends StatelessWidget {
  final TaskModel task;
  final Function(TaskStatus) onStatusChanged;

  const _TaskListItem({
    required this.task,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ListTile(
        contentPadding: const EdgeInsets.all(AppSpacing.md),
        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(task.description, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Row(
              children: [
                _PriorityBadge(priority: task.priority),
                const SizedBox(width: 8),
                Text(
                  'Due: ${task.dueDate.day}/${task.dueDate.month}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<TaskStatus>(
          initialValue: task.status,
          onSelected: onStatusChanged,
          itemBuilder: (context) => [
            const PopupMenuItem(value: TaskStatus.todo, child: Text('To Do')),
            const PopupMenuItem(value: TaskStatus.inProgress, child: Text('In Progress')),
            const PopupMenuItem(value: TaskStatus.completed, child: Text('Completed')),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(task.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              task.status.name.toUpperCase(),
              style: TextStyle(color: _getStatusColor(task.status), fontSize: 10, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(TaskStatus status) {
    switch (status) {
      case TaskStatus.todo: return Colors.grey;
      case TaskStatus.inProgress: return AppColors.accent;
      case TaskStatus.completed: return AppColors.success;
    }
  }
}

class _PriorityBadge extends StatelessWidget {
  final TaskPriority priority;
  const _PriorityBadge({required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (priority) {
      case TaskPriority.high: color = AppColors.error; break;
      case TaskPriority.medium: color = Colors.orange; break;
      case TaskPriority.low: color = AppColors.success; break;
    }
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
