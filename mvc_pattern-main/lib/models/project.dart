class Project {
  String id;
  String group;
  String name;
  String description;
  DateTime startDate;
  DateTime endDate;
  String logoPlaceholder; // path or base64 — here we use a simple text placeholder


  Project({
    required this.id,
    required this.group,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.logoPlaceholder = '',
  });
}