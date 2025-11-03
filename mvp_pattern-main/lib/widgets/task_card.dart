import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart'; // ✅ import the real model

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  Color _statusColor(TaskStatus s) {
    switch (s) {
      case TaskStatus.done:
        return Colors.purple;
      case TaskStatus.inProgress:
        return Colors.orange;
      case TaskStatus.todo:
      default:
        return Colors.grey.shade600;
    }
  }

  String _statusText(TaskStatus s) {
    switch (s) {
      case TaskStatus.done:
        return "Done";
      case TaskStatus.inProgress:
        return "In Progress";
      default:
        return "To-do";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  SizedBox(height: 6),
                  Text(task.subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  SizedBox(height: 8),
                  Text(DateFormat.jm().format(task.time), style: TextStyle(color: Colors.grey[700])),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _statusColor(task.status).withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _statusText(task.status),
                style: TextStyle(color: _statusColor(task.status), fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
