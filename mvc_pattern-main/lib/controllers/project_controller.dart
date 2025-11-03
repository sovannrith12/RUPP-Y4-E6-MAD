import '../models/project.dart';
import 'package:uuid/uuid.dart';

class ProjectController {
  // Singleton setup
  static final ProjectController _instance = ProjectController._internal();
  factory ProjectController() => _instance;
  ProjectController._internal();

  final List<Project> _projects = [
    Project(
      id: const Uuid().v4(),
      group: 'Work',
      name: 'Grocery App Redesign',
      description: 'Redesign the grocery shopping app UI/UX',
      startDate: DateTime(2025, 10, 1),
      endDate: DateTime(2025, 10, 30),
      logoPlaceholder: '',
    ),
    Project(
      id: const Uuid().v4(),
      group: 'Personal',
      name: 'Portfolio Website',
      description: 'Build a personal portfolio website with Flutter',
      startDate: DateTime(2025, 9, 15),
      endDate: DateTime(2025, 10, 15),
      logoPlaceholder: '',
    ),
    Project(
      id: const Uuid().v4(),
      group: 'Shopping',
      name: 'Christmas Gifts List',
      description: 'Plan and organize gifts for family and friends',
      startDate: DateTime(2025, 12, 1),
      endDate: DateTime(2025, 12, 25),
      logoPlaceholder: '',
    ),
  ];

  List<Project> getAll() => List.unmodifiable(_projects);

  void addProject({
    required String group,
    required String name,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final newProject = Project(
      id: const Uuid().v4(),
      group: group,
      name: name,
      description: description,
      startDate: startDate,
      endDate: endDate,
      logoPlaceholder: '',
    );
    _projects.add(newProject);
  }
}
