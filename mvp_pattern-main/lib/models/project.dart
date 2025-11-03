class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String taskGroup;
  final DateTime startDate;
  final DateTime endDate;
  final String? logoPath;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.taskGroup,
    required this.startDate,
    required this.endDate,
    this.logoPath,
  });
}
