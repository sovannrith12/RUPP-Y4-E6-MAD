import '../models/task.dart';

class TaskRepository {
  // Singleton
  static final TaskRepository _instance = TaskRepository._internal();

  factory TaskRepository() => _instance;

  TaskRepository._internal();

  // Local in-memory task list
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Design Landing Page',
      subtitle: 'UI/UX Team',
      time: DateTime(2022, 5, 25, 9, 0),
      status: TaskStatus.inProgress,
    ),
    Task(
      id: '2',
      title: 'Fix API Integration',
      subtitle: 'Backend Group',
      time: DateTime(2022, 5, 25, 11, 30),
      status: TaskStatus.todo,
    ),
    Task(
      id: '3',
      title: 'Team Meeting',
      subtitle: 'Project Alpha',
      time: DateTime(2022, 5, 25, 14, 0),
      status: TaskStatus.done,
    ),
  ];

  List<Task> fetchTasksFiltered(DateTime date, String filter) {
    List<Task> filtered = _tasks.where((t) {
      return t.time.year == date.year &&
          t.time.month == date.month &&
          t.time.day == date.day;
    }).toList();

    switch (filter) {
      case 'To do':
        filtered = filtered.where((t) => t.status == TaskStatus.todo).toList();
        break;
      case 'In Progress':
        filtered = filtered.where((t) => t.status == TaskStatus.inProgress).toList();
        break;
      case 'Completed':
        filtered = filtered.where((t) => t.status == TaskStatus.done).toList();
        break;
      default:
        break;
    }

    return filtered;
  }

  void addTask(Task task) {
    _tasks.add(task);
  }

  List<Task> getAllTasks() => List.unmodifiable(_tasks);
}
