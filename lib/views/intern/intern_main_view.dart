import 'package:flutter/material.dart';
import 'package:intern_management_system/core/app_theme.dart';
import 'package:intern_management_system/models/user.dart';
import 'package:intern_management_system/views/intern/intern_dashboard_view.dart';
import 'package:intern_management_system/views/intern/task_tracker_view.dart';
import 'package:intern_management_system/views/intern/resource_center_view.dart';
import 'package:intern_management_system/views/intern/attendance_view.dart';
import 'package:intern_management_system/views/welcome_screen.dart';
import 'package:intern_management_system/views/intern/notifications_view.dart';

// Feature Imports
import 'package:intern_management_system/views/intern/features/messaging_view.dart';
import 'package:intern_management_system/views/intern/features/leave_management_view.dart';
import 'package:intern_management_system/views/intern/features/skills_tracker_view.dart';
import 'package:intern_management_system/views/intern/features/document_vault_view.dart';
import 'package:intern_management_system/views/intern/features/events_view.dart';
import 'package:intern_management_system/views/intern/features/daily_standup_view.dart';
import 'package:intern_management_system/views/intern/features/careers_view.dart';
import 'package:intern_management_system/views/intern/features/support_view.dart';

class InternMainView extends StatefulWidget {
  final UserModel user;
  const InternMainView({super.key, required this.user});

  @override
  State<InternMainView> createState() => _InternMainViewState();
}

class _InternMainViewState extends State<InternMainView> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      InternDashboardView(user: widget.user),
      const TaskTrackerView(),
      const MessagingView(),
      const AttendanceView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsView()),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_rounded),
            selectedIcon: Icon(Icons.task_alt),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_outlined),
            selectedIcon: Icon(Icons.timer),
            label: 'Time Log',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 12),
                Text(widget.user.name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(widget.user.email, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          _DrawerItem(icon: Icons.rocket_launch_outlined, label: 'Skills Tracker', onTap: () => _navigateTo(const SkillsTrackerView())),
          _DrawerItem(icon: Icons.event_note_outlined, label: 'Events & Workshops', onTap: () => _navigateTo(const EventsView())),
          _DrawerItem(icon: Icons.work_history_outlined, label: 'Leave Requests', onTap: () => _navigateTo(const LeaveManagementView())),
          _DrawerItem(icon: Icons.library_books_outlined, label: 'Resource Center', onTap: () => _navigateTo(const ResourceCenterView())),
          _DrawerItem(icon: Icons.verified_user_outlined, label: 'Document Vault', onTap: () => _navigateTo(const DocumentVaultView())),
          const Divider(),
          _DrawerItem(icon: Icons.edit_note_outlined, label: 'Daily Standup', onTap: () => _navigateTo(const DailyStandupView())),
          _DrawerItem(icon: Icons.work_outline, label: 'Internal Careers', onTap: () => _navigateTo(const CareersBoardView())),
          _DrawerItem(icon: Icons.help_outline, label: 'Help & Support', onTap: () => _navigateTo(const SupportCenterView())),
          const Divider(),
          _DrawerItem(
            icon: Icons.logout_rounded,
            label: 'Logout',
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  void _navigateTo(Widget screen) {
    Navigator.pop(context); // Close drawer
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0: return 'Overview';
      case 1: return 'Task Tracking';
      case 2: return 'Messaging';
      case 3: return 'Work Logs';
      default: return 'IMS';
    }
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
    );
  }
}
