import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/models/enterprise_models.dart';
import 'package:intern_management_system/services/app_repository.dart';

class LeaveManagementView extends StatefulWidget {
  const LeaveManagementView({super.key});

  @override
  State<LeaveManagementView> createState() => _LeaveManagementViewState();
}

class _LeaveManagementViewState extends State<LeaveManagementView> {
  final _repository = AppRepository();

  void _requestLeave() {
    // Show simple dialog for request
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Leave'),
        content: const Text('Submit a new leave request for approval?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _repository.addLeaveRequest(LeaveRequest(
                  id: DateTime.now().toString(),
                  type: 'Personal Leave',
                  startDate: DateTime.now().add(const Duration(days: 10)),
                  endDate: DateTime.now().add(const Duration(days: 11)),
                  reason: 'Family event',
                ));
              });
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Leave Management')),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: _repository.leaves.length,
        itemBuilder: (context, index) {
          final leave = _repository.leaves[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: ListTile(
              title: Text(leave.type, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${leave.startDate.day}/${leave.startDate.month} - ${leave.endDate.day}/${leave.endDate.month}\nReason: ${leave.reason}'),
              trailing: _StatusChip(status: leave.status),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _requestLeave,
        label: const Text('Request Leave'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final LeaveStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status) {
      case LeaveStatus.approved: color = AppColors.success; break;
      case LeaveStatus.rejected: color = AppColors.error; break;
      case LeaveStatus.pending: color = Colors.orange; break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status.name.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
