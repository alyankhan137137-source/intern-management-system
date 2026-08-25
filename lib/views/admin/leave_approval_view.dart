import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_constants.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/services/app_repository.dart';
import 'package:intern_management_system/models/enterprise_models.dart';

class LeaveApprovalView extends StatefulWidget {
  const LeaveApprovalView({super.key});

  @override
  State<LeaveApprovalView> createState() => _LeaveApprovalViewState();
}

class _LeaveApprovalViewState extends State<LeaveApprovalView> {
  final _repository = AppRepository();

  void _handleApproval(String leaveId, bool approved) {
    setState(() {
      _repository.approveLeave(leaveId, approved);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(approved ? 'Leave Approved' : 'Leave Rejected')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendingLeaves = _repository.leaves.where((l) => l.status == LeaveStatus.pending).toList();
    final historyLeaves = _repository.leaves.where((l) => l.status != LeaveStatus.pending).toList();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Pending Requests'),
              Tab(text: 'Decision History'),
            ],
            labelColor: AppColors.accent,
            indicatorColor: AppColors.accent,
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildLeaveList(pendingLeaves, isPending: true),
                _buildLeaveList(historyLeaves, isPending: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveList(List<LeaveRequest> list, {required bool isPending}) {
    if (list.isEmpty) {
      return const Center(child: Text('No leave requests found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final leave = list[index];
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
                    Text(leave.type, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (!isPending) _StatusChip(status: leave.status),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Duration: ${leave.startDate.day}/${leave.startDate.month} - ${leave.endDate.day}/${leave.endDate.month}'),
                Text('Reason: ${leave.reason}', style: const TextStyle(color: AppColors.textSecondary)),
                if (isPending) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _handleApproval(leave.id, false),
                          style: OutlinedButton.styleFrom(foregroundColor: AppColors.error),
                          child: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => _handleApproval(leave.id, true),
                          style: ElevatedButton.styleFrom(backgroundColor: AppColors.success, foregroundColor: Colors.white),
                          child: const Text('Approve'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatusChip extends StatelessWidget {
  final LeaveStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color color = status == LeaveStatus.approved ? AppColors.success : AppColors.error;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status.name.toUpperCase(), style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
