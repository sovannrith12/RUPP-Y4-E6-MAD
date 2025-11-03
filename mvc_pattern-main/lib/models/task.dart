class Task {
  final String id;
  final String title;
  final String subtitle;
  final String time; // human readable (e.g., "10:00 AM")
  final TaskStatus status;


  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    this.status = TaskStatus.todo,
  });
}


enum TaskStatus { todo, inProgress, done }