import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../repositories/task_repository.dart';
import '../views/home_view.dart';
import '../presenters/home_presenter.dart';
import '../widgets/date_selector.dart';
import '../widgets/task_card.dart';
import '../screens/add_project_screen.dart';
import '../models/project.dart';
import '../widgets/bottom_nav_with_fab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeView {
  late HomePresenter presenter;
  final repository = TaskRepository();

  bool loading = false;
  List<Task> tasks = [];
  DateTime selectedDate = DateTime(2022, 5, 25);
  String selectedFilter = 'All';
  int bottomIndex = 0;

  final filters = ['All', 'To do', 'In Progress', 'Completed'];

  @override
  void initState() {
    super.initState();
    presenter = HomePresenter(
      view: this,
      repository: repository,
      currentDate: selectedDate, // ✅ matches presenter
    );
    presenter.loadTasks();
  }

  @override
  void hideLoading() {
    setState(() {
      loading = false;
    });
  }

  @override
  void showLoading() {
    setState(() {
      loading = true;
    });
  }

  @override
  void showTasks(List<Task> tasks) {
    setState(() {
      this.tasks = tasks;
    });
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void updateSelectedDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  void updateFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  List<DateTime> _fiveDates() {
    // May 23 -> May 27 (2022)
    return List.generate(5, (i) => DateTime(2022, 5, 23 + i));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.maybePop(context)),
        title: Text("Today's Tasks", style: GoogleFonts.lato(fontWeight: FontWeight.w700)),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.notifications_none), onPressed: () {})],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            DateSelector(
              dates: _fiveDates(),
              selected: selectedDate,
              onSelect: (d) => presenter.selectDate(d),
            ),
            SizedBox(height: 8),
            // Filters
            Container(
              height: 44,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, __) => SizedBox(width: 10),
                itemBuilder: (ctx, idx) {
                  final f = filters[idx];
                  final isSelected = f == selectedFilter;
                  return GestureDetector(
                    onTap: () => presenter.selectFilter(f),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        f,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            // Task list
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : tasks.isEmpty
                  ? Center(child: Text("No tasks for ${DateFormat.yMMMd().format(selectedDate)}"))
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (ctx, i) {
                  return TaskCard(task: tasks[i]); // ✅ pass Task object
                },
              )
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: Icon(Icons.add, size: 32),
        onPressed: () async {
          final newProject = await Navigator.push<ProjectModel?>(
            context,
            MaterialPageRoute(builder: (_) => AddProjectScreen()),
          );

          if (newProject != null) {
            // Convert ProjectModel -> Task
            final taskFromProject = Task(
              id: newProject.id,
              title: newProject.name,
              subtitle: newProject.taskGroup,
              time: newProject.startDate,
              status: TaskStatus.todo,
            );

            // Add to repository and local state
            repository.addTask(taskFromProject);
            setState(() {
              tasks.add(taskFromProject);
            });
          }
        },
      ),
      bottomNavigationBar: BottomNavWithFab(
        currentIndex: bottomIndex,
        onTap: (idx) => setState(() => bottomIndex = idx),
        onFabTap: () async {
          final newProject = await Navigator.push<ProjectModel?>(
            context,
            MaterialPageRoute(builder: (_) => AddProjectScreen()),
          );

          if (newProject != null) {
            final taskFromProject = Task(
              id: newProject.id,
              title: newProject.name,
              subtitle: newProject.taskGroup,
              time: newProject.startDate,
              status: TaskStatus.todo,
            );
            repository.addTask(taskFromProject);
            setState(() {
              tasks.add(taskFromProject);
            });
          }
        },
      ),
    );
  }
}
