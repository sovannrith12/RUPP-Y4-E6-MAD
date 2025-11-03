import 'package:flutter/material.dart';
import '../controllers/project_controller.dart';
import '../models/project.dart';
import 'widgets/date_selector.dart';
import 'widgets/bottom_nav_bar.dart';
import 'add_project_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProjectController _projectController = ProjectController();

  DateTime _selectedDate = DateTime(2022, 5, 25);
  int _navIndex = 0;
  String _selectedGroup = 'All';

  // Updated groups
  List<String> _groups = ['All', 'Work', 'Personal', 'Shopping'];

  List<DateTime> _buildDates() {
    return List.generate(5, (i) => DateTime(2022, 5, 23 + i));
  }

  List<Project> _getFilteredProjects() {
    final allProjects = _projectController.getAll();
    if (_selectedGroup == 'All') return allProjects;
    return allProjects.where((p) => p.group == _selectedGroup).toList();
  }

  String _formatDateWithMonth(DateTime d) {
    const monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return '${d.day} ${monthNames[d.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final dates = _buildDates();
    final projects = _getFilteredProjects();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: const Text("Today's Projects",
            style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          // Date selector with day + month
          DateSelector(
            dates: dates,
            selected: _selectedDate,
            displayDate: (d) => _formatDateWithMonth(d),
            onSelect: (d) => setState(() => _selectedDate = d),
          ),
          const SizedBox(height: 8),
          _buildFilterRow(),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: projects.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (ctx, i) {
                  final project = projects[i];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 6)
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(project.name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 6),
                        Text(project.description,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[600])),
                        const SizedBox(height: 4),
                        Text(
                            '${_formatDateWithMonth(project.startDate)} - ${_formatDateWithMonth(project.endDate)}',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700])),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
        onCentralTap: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddProjectScreen()),
          );
          if (result == true) setState(() {});
        },
      ),
    );
  }

  Widget _buildFilterRow() {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: _groups.length,
        itemBuilder: (context, index) {
          final group = _groups[index];
          final selected = _selectedGroup == group;
          return GestureDetector(
            onTap: () => setState(() => _selectedGroup = group),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? Colors.deepPurple : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: selected
                    ? [BoxShadow(color: Colors.deepPurple.withOpacity(0.12), blurRadius: 8)]
                    : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
                border: Border.all(color: Colors.grey.withOpacity(0.15)),
              ),
              child: Text(
                group,
                style: TextStyle(
                    color: selected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      ),
    );
  }
}
