import 'package:flutter/material.dart';
import '../controllers/task_controller.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TaskController _taskController = TaskController();

  String _title = '';
  String _subtitle = '';
  String _time = '09:00 AM';
  TaskStatus _status = TaskStatus.todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text('Add Task',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Task Title'),
            const SizedBox(height: 8),
            TextField(
              onChanged: (v) => _title = v,
              decoration: InputDecoration(
                hintText: 'Enter task title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),

            _label('Subtitle / Description'),
            const SizedBox(height: 8),
            TextField(
              onChanged: (v) => _subtitle = v,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter description',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),

            _label('Time'),
            const SizedBox(height: 8),
            TextField(
              onChanged: (v) => _time = v,
              decoration: InputDecoration(
                hintText: 'Enter time (e.g. 10:00 AM)',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),

            _label('Status'),
            const SizedBox(height: 8),
            DropdownButton<TaskStatus>(
              value: _status,
              items: TaskStatus.values
                  .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.name[0].toUpperCase() + e.name.substring(1)),
              ))
                  .toList(),
              onChanged: (v) => setState(() => _status = v!),
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  if (_title.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Task title required')));
                    return;
                  }

                  // Add Task to controller
                  _taskController.addTask(Task(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: _title,
                    subtitle: _subtitle,
                    time: _time,
                    status: _status,
                  ));

                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Task added')));

                  Navigator.of(context).pop(true); // return true to refresh
                },
                child: const Text('Add Task',
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) =>
      Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 13));
}
