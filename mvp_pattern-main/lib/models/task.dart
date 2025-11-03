enum TaskStatus { done, inProgress, todo }

class Task {
  final String id;
  final String title;
  final String subtitle; // e.g., project or group
  final DateTime time;
  final TaskStatus status;

  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.status,
  });
}
