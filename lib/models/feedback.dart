class MentorFeedback {
  final String id;
  final String mentorName;
  final String comment;
  final double rating;
  final DateTime date;

  MentorFeedback({
    required this.id,
    required this.mentorName,
    required this.comment,
    required this.rating,
    required this.date,
  });
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });
}
