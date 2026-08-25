import 'package:flutter/material.dart';
import 'package:intern_management_system/models/task.dart';
import 'package:intern_management_system/models/resource.dart';
import 'package:intern_management_system/models/attendance.dart';
import 'package:intern_management_system/models/feedback.dart';
import 'package:intern_management_system/models/enterprise_models.dart';
import 'package:intern_management_system/models/user.dart';

class AppRepository {
  static final AppRepository _instance = AppRepository._internal();
  factory AppRepository() => _instance;
  AppRepository._internal();

  // Interns List
  final List<UserModel> _interns = [
    UserModel(id: '1', email: 'alyankhan@internee.pk', name: 'Alyan Khan', role: UserRole.intern),
    UserModel(id: '3', email: 'ahmed.ali@internee.pk', name: 'Ahmed Ali', role: UserRole.intern),
    UserModel(id: '4', email: 'fatima.zahra@internee.pk', name: 'Fatima Zahra', role: UserRole.intern),
    UserModel(id: '5', email: 'usman.m@internee.pk', name: 'Muhammad Usman', role: UserRole.intern),
    UserModel(id: '6', email: 'zoya.ahmed@internee.pk', name: 'Zoya Ahmed', role: UserRole.intern),
    UserModel(id: '7', email: 'hamza.malik@internee.pk', name: 'Hamza Malik', role: UserRole.intern),
    UserModel(id: '8', email: 'aisha.noor@internee.pk', name: 'Aisha Noor', role: UserRole.intern),
    UserModel(id: '9', email: 'bilal.s@internee.pk', name: 'Bilal Sheikh', role: UserRole.intern),
    UserModel(id: '10', email: 'sana.khan@internee.pk', name: 'Sana Khan', role: UserRole.intern),
    UserModel(id: '11', email: 'mustafa.raza@internee.pk', name: 'Mustafa Raza', role: UserRole.intern),
    UserModel(id: '12', email: 'hira.mani@internee.pk', name: 'Hira Mani', role: UserRole.intern),
    UserModel(id: '13', email: 'omer.f@internee.pk', name: 'Omer Farooq', role: UserRole.intern),
    UserModel(id: '14', email: 'zainab.b@internee.pk', name: 'Zainab Bibi', role: UserRole.intern),
    UserModel(id: '15', email: 'abdullah.shah@internee.pk', name: 'Abdullah Shah', role: UserRole.intern),
  ];

  // Existing Mock Data...
  final List<TaskModel> _tasks = [
    TaskModel(
      id: '1',
      title: 'UI Refactor - Dashboard',
      description: 'Upgrade the dashboard to Material 3 components and ensure responsiveness.',
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      dueDate: DateTime.now().add(const Duration(days: 2)),
      subtasks: ['Update Cards', 'Implement Shimmer', 'Fix padding'],
    ),
    TaskModel(
      id: '2',
      title: 'API Integration - Auth',
      description: 'Connect the login flow to the backend authentication endpoint.',
      priority: TaskPriority.high,
      status: TaskStatus.todo,
      dueDate: DateTime.now().add(const Duration(days: 4)),
    ),
    TaskModel(
      id: '3',
      title: 'Security Audit',
      description: 'Review the current implementation for potential data leaks.',
      priority: TaskPriority.medium,
      status: TaskStatus.completed,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TaskModel(
      id: '4',
      title: 'Documentation Update',
      description: 'Update the project README and technical documentation.',
      priority: TaskPriority.low,
      status: TaskStatus.inProgress,
      dueDate: DateTime.now().add(const Duration(days: 7)),
    ),
    ...List.generate(6, (index) => TaskModel(
      id: 'task_${index + 5}',
      title: 'Enterprise Task #${index + 5}',
      description: 'A detailed description for a high-priority enterprise task.',
      priority: index % 2 == 0 ? TaskPriority.medium : TaskPriority.low,
      status: TaskStatus.todo,
      dueDate: DateTime.now().add(Duration(days: index + 10)),
    )),
  ];

  // New Enterprise Mock Data
  final List<MessageModel> _messages = [
    MessageModel(id: '1', senderName: 'Saima Akram', content: 'Hey! How is the UI refactor going?', timestamp: DateTime.now().subtract(const Duration(minutes: 30)), isMe: false),
    MessageModel(id: '2', senderName: 'Me', content: 'Going great, just finished the main metrics grid.', timestamp: DateTime.now().subtract(const Duration(minutes: 25)), isMe: true),
    MessageModel(id: '3', senderName: 'Saima Akram', content: 'Perfect. Let me know if you need help with the charts.', timestamp: DateTime.now().subtract(const Duration(minutes: 20)), isMe: false),
  ];

  final List<LeaveRequest> _leaves = [
    LeaveRequest(id: '1', type: 'Sick Leave', startDate: DateTime.now().add(const Duration(days: 5)), endDate: DateTime.now().add(const Duration(days: 6)), reason: 'Dental appointment', status: LeaveStatus.approved),
  ];

  final List<SkillModel> _skills = [
    SkillModel(name: 'Flutter', level: 0.85, color: Colors.blue),
    SkillModel(name: 'Dart', level: 0.90, color: Colors.cyan),
    SkillModel(name: 'UI Design', level: 0.70, color: Colors.purple),
    SkillModel(name: 'Architecture', level: 0.60, color: Colors.indigo),
  ];

  final List<EventModel> _events = [
    EventModel(id: '1', title: 'Tech Talk: Flutter 4.0', time: '10:00 AM', date: 'Aug 25', joinLink: 'zoom.us/j/123', icon: Icons.code_rounded),
    EventModel(id: '2', title: 'Team Luncheon', time: '01:00 PM', date: 'Aug 26', joinLink: 'office/hall-A', icon: Icons.restaurant_rounded),
    EventModel(id: '3', title: 'Security Workshop', time: '03:00 PM', date: 'Aug 28', joinLink: 'meet.google.com/xyz', icon: Icons.security_rounded),
  ];

  final List<DocumentModel> _documents = [
    DocumentModel(id: '1', name: 'Internship Contract', type: 'PDF', expiryDate: '2026-12-31'),
    DocumentModel(id: '2', name: 'Security Policy', type: 'PDF', expiryDate: 'N/A'),
    DocumentModel(id: '3', name: 'Completion Certificate', type: 'Certificate', expiryDate: 'N/A'),
  ];

  final List<JobModel> _jobs = [
    JobModel(id: '1', title: 'Junior Flutter Developer', department: 'Product', type: 'Full-time', description: 'Seeking a high-performing intern to join the mobile team.'),
    JobModel(id: '2', title: 'Product Designer', department: 'Design', type: 'Full-time', description: 'Full-time role for interns with strong M3 design skills.'),
  ];

  // Rest of the class remains similar but with added getters...
  final List<ResourceModel> _resources = [
    ResourceModel(id: 'r1', title: 'Employee Handbook', category: 'HR', type: ResourceType.pdf, url: 'https://example.com/handbook.pdf', description: 'Official guidelines and company policies.'),
    ResourceModel(id: 'r2', title: 'Dart Style Guide', category: 'Development', type: ResourceType.link, url: 'https://dart.dev/guides/language/effective-dart/style', description: 'Best practices for writing clean Dart code.'),
    ResourceModel(id: 'r3', title: 'Onboarding Video', category: 'Company', type: ResourceType.video, url: 'https://example.com/onboarding.mp4', description: 'Introduction to our company culture.'),
  ];

  final List<AttendanceLog> _attendanceHistory = [
    AttendanceLog(id: 'a1', date: DateTime.now().subtract(const Duration(days: 1)), clockIn: DateTime.now().subtract(const Duration(days: 1, hours: 9)), clockOut: DateTime.now().subtract(const Duration(days: 1, hours: 1)), status: AttendanceStatus.present, location: 'Remote'),
    AttendanceLog(id: 'a2', date: DateTime.now().subtract(const Duration(days: 2)), clockIn: DateTime.now().subtract(const Duration(days: 2, hours: 8)), clockOut: DateTime.now().subtract(const Duration(days: 2, hours: 0)), status: AttendanceStatus.present, location: 'Office'),
  ];

  final List<MentorFeedback> _feedback = [
    MentorFeedback(id: 'f1', mentorName: 'Saima Akram', comment: 'Excellent progress on the UI refactor. The attention to detail is impressive.', rating: 4.8, date: DateTime.now().subtract(const Duration(days: 3))),
    MentorFeedback(id: 'f2', mentorName: 'Saima Akram', comment: 'Good start on the documentation. Try to be more concise in the API section.', rating: 4.2, date: DateTime.now().subtract(const Duration(days: 10))),
  ];

  final List<NotificationModel> _notifications = [
    NotificationModel(id: 'n1', title: 'Task Assigned', message: 'You have been assigned to UI Refactor - Dashboard.', timestamp: DateTime.now().subtract(const Duration(hours: 2))),
    NotificationModel(id: 'n2', title: 'Feedback Received', message: 'Saima Akram left a new feedback on your performance.', timestamp: DateTime.now().subtract(const Duration(days: 3))),
  ];

  final List<AnnouncementModel> _announcements = [
    AnnouncementModel(id: '1', title: 'Town Hall Meeting', message: 'Join us for the monthly town hall tomorrow at 10 AM.', date: DateTime.now(), isPriority: true),
    AnnouncementModel(id: '2', title: 'Holiday Notice', message: 'The office will be closed this Friday for a public holiday.', date: DateTime.now().subtract(const Duration(days: 2))),
  ];

  final List<StandupModel> _standups = [
    StandupModel(id: '1', internId: '1', internName: 'Alyan Khan', content: 'Finished UI refactor', blockers: 'None', date: DateTime.now()),
  ];

  final List<AuditLogModel> _auditLogs = [
    AuditLogModel(id: '1', action: 'Assigned Task: UI Refactor', adminName: 'Admin User', timestamp: DateTime.now().subtract(const Duration(hours: 5))),
  ];

  final List<CertificateModel> _certificates = [];

  // Getters
  List<UserModel> get interns => List.unmodifiable(_interns);
  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  List<ResourceModel> get resources => List.unmodifiable(_resources);
  List<AttendanceLog> get attendanceHistory => List.unmodifiable(_attendanceHistory);
  List<MentorFeedback> get feedback => List.unmodifiable(_feedback);
  List<NotificationModel> get notifications => List.unmodifiable(_notifications);
  List<MessageModel> get messages => List.unmodifiable(_messages);
  List<LeaveRequest> get leaves => List.unmodifiable(_leaves);
  List<SkillModel> get skills => List.unmodifiable(_skills);
  List<EventModel> get events => List.unmodifiable(_events);
  List<DocumentModel> get documents => List.unmodifiable(_documents);
  List<JobModel> get jobs => List.unmodifiable(_jobs);
  List<AnnouncementModel> get announcements => List.unmodifiable(_announcements);
  List<StandupModel> get standups => List.unmodifiable(_standups);
  List<AuditLogModel> get auditLogs => List.unmodifiable(_auditLogs);
  List<CertificateModel> get certificates => List.unmodifiable(_certificates);

  // Methods...
  void updateTaskStatus(String taskId, TaskStatus newStatus) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) _tasks[index].status = newStatus;
  }

  void addAttendanceLog(AttendanceLog log) => _attendanceHistory.insert(0, log);
  void addLeaveRequest(LeaveRequest request) => _leaves.insert(0, request);
  void sendMessage(String content) => _messages.add(MessageModel(id: DateTime.now().toString(), senderName: 'Me', content: content, timestamp: DateTime.now(), isMe: true));
  
  // Admin Methods
  void addIntern(UserModel intern) {
    _interns.add(intern);
    _addAuditLog('Added Intern: ${intern.name}');
  }

  void updateIntern(UserModel intern) {
    final index = _interns.indexWhere((i) => i.id == intern.id);
    if (index != -1) {
      _interns[index] = intern;
      _addAuditLog('Updated Intern: ${intern.name}');
    }
  }

  void assignTask(TaskModel task) {
    _tasks.add(task);
    _addAuditLog('Assigned Task: ${task.title}');
  }

  void approveLeave(String leaveId, bool approved) {
    final index = _leaves.indexWhere((l) => l.id == leaveId);
    if (index != -1) {
      _leaves[index] = LeaveRequest(
        id: _leaves[index].id,
        type: _leaves[index].type,
        startDate: _leaves[index].startDate,
        endDate: _leaves[index].endDate,
        reason: _leaves[index].reason,
        status: approved ? LeaveStatus.approved : LeaveStatus.rejected,
      );
      _addAuditLog('${approved ? 'Approved' : 'Rejected'} Leave Request: $leaveId');
    }
  }

  void postAnnouncement(AnnouncementModel announcement) {
    _announcements.insert(0, announcement);
    _addAuditLog('Posted Announcement: ${announcement.title}');
  }

  void addStandup(StandupModel standup) {
    _standups.insert(0, standup);
  }

  void _addAuditLog(String action) {
    _auditLogs.insert(0, AuditLogModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      action: action,
      adminName: 'Admin User',
      timestamp: DateTime.now(),
    ));
  }
  
  double get taskCompletionRate {
    if (_tasks.isEmpty) return 0;
    final completed = _tasks.where((t) => t.status == TaskStatus.completed).length;
    return completed / _tasks.length;
  }
  int get pendingTasksCount => _tasks.where((t) => t.status != TaskStatus.completed).length;
  double get averageRating {
    if (_feedback.isEmpty) return 0;
    return _feedback.fold(0.0, (sum, f) => sum + f.rating) / _feedback.length;
  }
}
