import 'package:flutter/material.dart';

// 1. Messaging
class MessageModel {
  final String id;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isMe;

  MessageModel({
    required this.id,
    required this.senderName,
    required this.content,
    required this.timestamp,
    required this.isMe,
  });
}

// 2. Leaves
enum LeaveStatus { pending, approved, rejected }
class LeaveRequest {
  final String id;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final LeaveStatus status;

  LeaveRequest({
    required this.id,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.reason,
    this.status = LeaveStatus.pending,
  });
}

// 3. Skills
class SkillModel {
  final String name;
  final double level; // 0.0 to 1.0
  final Color color;

  SkillModel({
    required this.name,
    required this.level,
    required this.color,
  });
}

// 4. Events
class EventModel {
  final String id;
  final String title;
  final String time;
  final String date;
  final String joinLink;
  final IconData icon;

  EventModel({
    required this.id,
    required this.title,
    required this.time,
    required this.date,
    required this.joinLink,
    required this.icon,
  });
}

// 5. Documents
class DocumentModel {
  final String id;
  final String name;
  final String type;
  final String expiryDate;

  DocumentModel({
    required this.id,
    required this.name,
    required this.type,
    required this.expiryDate,
  });
}

// 6. Jobs
class JobModel {
  final String id;
  final String title;
  final String department;
  final String type;
  final String description;

  JobModel({
    required this.id,
    required this.title,
    required this.department,
    required this.type,
    required this.description,
  });
}
