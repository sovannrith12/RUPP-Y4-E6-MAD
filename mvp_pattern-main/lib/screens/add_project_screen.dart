import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../presenters/add_project_presenter.dart';
import '../views/add_project_view.dart';
import '../models/project.dart';
import '../models/task.dart';          // ← added
import '../repositories/task_repository.dart';  // ← added


class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> implements AddProjectView {
  late AddProjectPresenter presenter;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: "Grocery Shopping App");
  final _descController = TextEditingController(
      text:
      "This application is designed for super shops. By using this application they can enlist all their products in one place and can deliver. Customers will get a one-stop solution for their daily shopping.");
  String taskGroup = "Work";
  DateTime startDate = DateTime(2022, 5, 1);
  DateTime endDate = DateTime(2022, 6, 30);
  bool loading = false;

  @override
  void initState() {
    super.initState();
    presenter = AddProjectPresenter(this);
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
  void onProjectAdded(ProjectModel project) {
    setState(() {
      loading = false;
    });

    // Convert Project to Task
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: project.name,
      subtitle: project.taskGroup,
      time: project.startDate,
      status: TaskStatus.todo,
    );

    // Add to repository
    final repo = TaskRepository();
    repo.addTask(newTask);

    // Return project to previous screen
    Navigator.pop(context, project);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Project '${project.name}' added")));
  }


  @override
  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? startDate : endDate;
    final chosen = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (chosen != null) {
      setState(() {
        if (isStart) startDate = chosen;
        else endDate = chosen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      radius: 28,
      backgroundColor: Colors.orange,
      child: Icon(Icons.shopping_bag, color: Colors.white),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Project"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Card with logo and change button
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  children: [
                    logo,
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Grocery shop", style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(height: 4),
                        Text("Project", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    Spacer(),
                    TextButton.icon(onPressed: () {}, icon: Icon(Icons.photo_camera), label: Text("Change Logo")),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Task Group
                  Align(alignment: Alignment.centerLeft, child: Text("Task Group", style: TextStyle(color: Colors.grey[700]))),
                  SizedBox(height: 6),
                  GestureDetector(
                    onTap: () {
                      // show simple selection
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return ListView(
                            shrinkWrap: true,
                            children: ["Work", "Personal", "Others"].map((g) {
                              return ListTile(
                                title: Text(g),
                                onTap: () {
                                  setState(() {
                                    taskGroup = g;
                                  });
                                  Navigator.pop(ctx);
                                },
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey.shade200)),
                      child: Row(
                        children: [
                          Icon(Icons.folder, color: Colors.pink),
                          SizedBox(width: 8),
                          Text(taskGroup, style: TextStyle(fontWeight: FontWeight.w600)),
                          Spacer(),
                          Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 14),

                  // Project Name
                  Align(alignment: Alignment.centerLeft, child: Text("Project Name", style: TextStyle(color: Colors.grey[700]))),
                  SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Project name",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    ),
                    validator: (v) => v == null || v.trim().isEmpty ? "Required" : null,
                  ),
                  SizedBox(height: 14),

                  // Description
                  Align(alignment: Alignment.centerLeft, child: Text("Description", style: TextStyle(color: Colors.grey[700]))),
                  SizedBox(height: 6),
                  TextFormField(
                    controller: _descController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                    ),
                  ),
                  SizedBox(height: 14),

                  // Dates
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start Date", style: TextStyle(color: Colors.grey[700])),
                            SizedBox(height: 6),
                            GestureDetector(
                              onTap: () => _pickDate(isStart: true),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                child: Row(
                                  children: [Icon(Icons.calendar_today), SizedBox(width: 8), Text(DateFormat("dd MMM, yyyy").format(startDate))],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("End Date", style: TextStyle(color: Colors.grey[700])),
                            SizedBox(height: 6),
                            GestureDetector(
                              onTap: () => _pickDate(isStart: false),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                child: Row(
                                  children: [Icon(Icons.calendar_today), SizedBox(width: 8), Text(DateFormat("dd MMM, yyyy").format(endDate))],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          presenter.addProject(
                            name: _nameController.text,
                            taskGroup: taskGroup,
                            description: _descController.text,
                            startDate: startDate,
                            endDate: endDate,
                            logoPath: null,
                          );
                        }
                      },
                      child: loading ? CircularProgressIndicator(color: Colors.white) : Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text("Add Project", style: TextStyle(fontSize: 16)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
