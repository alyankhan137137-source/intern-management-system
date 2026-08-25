enum TaskPriority { high, medium, low }
enum TaskStatus { todo, inProgress, completed }

class TaskModel {
  final String id;
  final String title;
  final String description;
  final TaskPriority priority;
  TaskStatus status;
  final DateTime dueDate;
  final List<String> subtasks;
  final List<String> comments;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.dueDate,
    this.subtasks = const [],
    this.comments = const [],
  });
}
