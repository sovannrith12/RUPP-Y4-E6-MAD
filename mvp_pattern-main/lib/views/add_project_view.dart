import '../models/project.dart';

abstract class AddProjectView {
  void showLoading();
  void hideLoading();
  void onProjectAdded(ProjectModel project);
  void showError(String message);

}
