import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/models/user.dart';
import 'package:intern_management_system/views/admin/admin_dashboard_view.dart';
import 'package:intern_management_system/views/admin/intern_management_view.dart';
import 'package:intern_management_system/views/admin/leave_approval_view.dart';
import 'package:intern_management_system/views/admin/audit_log_view.dart';
import 'package:intern_management_system/views/admin/feedback_hub_view.dart';
import 'package:intern_management_system/views/admin/attendance_analytics_view.dart';
import 'package:intern_management_system/views/welcome_screen.dart';

class AdminMainView extends StatefulWidget {
  final UserModel user;
  const AdminMainView({super.key, required this.user});

  @override
  State<AdminMainView> createState() => _AdminMainViewState();
}

class _AdminMainViewState extends State<AdminMainView> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      const AdminDashboardView(),
      const InternManagementView(),
      const LeaveApprovalView(),
      const AttendanceAnalyticsView(),
      const FeedbackHubView(),
      const AuditLogView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() => _currentIndex = index);
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.insights_rounded),
                selectedIcon: Icon(Icons.insights),
                label: Text('Stats'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outline_rounded),
                selectedIcon: Icon(Icons.people),
                label: Text('Interns'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.event_busy_outlined),
                selectedIcon: Icon(Icons.event_busy),
                label: Text('Leaves'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.timer_outlined),
                selectedIcon: Icon(Icons.timer),
                label: Text('Work'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.rate_review_outlined),
                selectedIcon: Icon(Icons.rate_review),
                label: Text('Feedback'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history_rounded),
                selectedIcon: Icon(Icons.history),
                label: Text('Logs'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0: return 'Admin Overview';
      case 1: return 'Intern Management';
      case 2: return 'Leave Approvals';
      case 3: return 'Attendance Reports';
      case 4: return 'Feedback Oversight';
      case 5: return 'System Audit Logs';
      default: return 'Admin Panel';
    }
  }
}
