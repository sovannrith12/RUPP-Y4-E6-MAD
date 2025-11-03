import '../views/home_view.dart';
import '../repositories/task_repository.dart';
import '../models/task.dart';

class HomePresenter {
  final HomeView view;
  final TaskRepository repository;
  DateTime currentDate;
  String currentFilter = 'All';

  HomePresenter({
    required this.view,
    required this.repository,
    required this.currentDate,
  });

  void loadTasks() {
    view.showLoading();
    final tasks = repository.fetchTasksFiltered(currentDate, currentFilter);
    view.hideLoading();
    view.showTasks(tasks);
  }

  void selectDate(DateTime date) {
    currentDate = date;
    view.updateSelectedDate(date);
    loadTasks();
  }

  void selectFilter(String filter) {
    currentFilter = filter;
    view.updateFilter(filter);
    loadTasks();
  }
}
