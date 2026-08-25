import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';
import 'package:intern_management_system/models/user.dart';
import 'package:intern_management_system/models/task.dart';
import 'package:intern_management_system/widgets/skeleton_loader.dart';

class InternManagementView extends StatefulWidget {
  const InternManagementView({super.key});

  @override
  State<InternManagementView> createState() => _InternManagementViewState();
}

class _InternManagementViewState extends State<InternManagementView> {
  final _repository = AppRepository();
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

  void _addIntern() {
    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String email = '';
        return AlertDialog(
          title: const Text('Add New Intern'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (name.isNotEmpty && email.isNotEmpty) {
                  setState(() {
                    _repository.addIntern(UserModel(
                      id: DateTime.now().toString(),
                      name: name,
                      email: email,
                      role: UserRole.intern,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _assignTask(UserModel intern) {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        return AlertDialog(
          title: Text('Assign Task to ${intern.name}'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Task Title'),
            onChanged: (value) => title = value,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty) {
                  setState(() {
                    _repository.assignTask(TaskModel(
                      id: DateTime.now().toString(),
                      title: title,
                      description: 'Custom task assigned by admin.',
                      priority: TaskPriority.medium,
                      status: TaskStatus.todo,
                      dueDate: DateTime.now().add(const Duration(days: 3)),
                    ));
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task assigned successfully!')),
                  );
                }
              },
              child: const Text('Assign'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SkeletonList();
    }
    final interns = _repository.interns;
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: interns.length,
        itemBuilder: (context, index) {
          final intern = interns[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.accent.withOpacity(0.1),
                child: Text(intern.name[0]),
              ),
              title: Text(intern.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(intern.email),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'task', child: Text('Assign Task')),
                  const PopupMenuItem(value: 'edit', child: Text('Edit Profile')),
                  const PopupMenuItem(value: 'delete', child: Text('Remove')),
                ],
                onSelected: (value) {
                  if (value == 'task') _assignTask(intern);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addIntern,
        label: const Text('Add Intern'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
