import '../models/task.dart';


class TaskController {
// Example static list - in real app you'd fetch from API/db
  final List<Task> _tasks = [
    Task(
      id: 't1',
      title: 'Market Research',
      subtitle: 'Grocery shopping app design',
      time: '10:00 AM',
      status: TaskStatus.done,
    ),
    Task(
      id: 't2',
      title: 'Competitive Analysis',
      subtitle: 'Grocery shopping app design',
      time: '12:00 PM',
      status: TaskStatus.inProgress,
    ),
    Task(
      id: 't3',
      title: 'Create Low-fidelity Wireframe',
      subtitle: 'Uber Eats redesign challenge',
      time: '07:00 PM',
      status: TaskStatus.todo,
    ),
    Task(
      id: 't4',
      title: 'How to pitch a Design Sprint',
      subtitle: 'About design sprint',
      time: '09:00 PM',
      status: TaskStatus.todo,
    ),
  ];


  List<Task> getAll() => List.unmodifiable(_tasks);


  List<Task> filterByStatus(TaskStatus? status) {
    if (status == null) return getAll();
    return _tasks.where((t) => t.status == status).toList();
  }


  void addTask(Task task) {
    _tasks.add(task);
  }
}