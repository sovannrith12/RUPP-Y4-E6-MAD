import 'package:uuid/uuid.dart';
import '../models/project.dart';
import '../views/add_project_view.dart';

class AddProjectPresenter {
  final AddProjectView view;

  AddProjectPresenter(this.view);

  Future<void> addProject({
    required String name,
    required String taskGroup,
    required String description,
    required DateTime startDate,
    required DateTime endDate,
    String? logoPath,
  }) async {
    if (name.trim().isEmpty) {
      view.showError("Project name is required");
      return;
    }
    view.showLoading();
    try {
      // simulate saving
      await Future.delayed(Duration(milliseconds: 600));
      final id = Uuid().v4();
      final project = ProjectModel(
        id: id,
        name: name,
        description: description,
        taskGroup: taskGroup,
        startDate: startDate,
        endDate: endDate,
        logoPath: logoPath,
      );
      // in real app: save to repo / backend
      view.onProjectAdded(project);
    } catch (e) {
      view.showError(e.toString());
    } finally {
      view.hideLoading();
    }
  }
}
