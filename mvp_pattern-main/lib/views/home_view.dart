import '../models/task.dart';

abstract class HomeView {
  void showLoading();
  void hideLoading();
  void showTasks(List<Task> tasks);
  void showError(String message);
  void updateSelectedDate(DateTime date);
  void updateFilter(String filter);
}
