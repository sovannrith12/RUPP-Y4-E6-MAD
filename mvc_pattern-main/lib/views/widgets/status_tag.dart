import 'package:flutter/material.dart';
import '../../models/task.dart';


class StatusTag extends StatelessWidget {
  final TaskStatus status;
  const StatusTag(this.status, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color textC;
    String label;
    switch (status) {
      case TaskStatus.done:
        bg = Colors.purple.shade700;
        textC = Colors.white;
        label = 'Done';
        break;
      case TaskStatus.inProgress:
        bg = Colors.orange.shade600;
        textC = Colors.white;
        label = 'In Progress';
        break;
      case TaskStatus.todo:
      default:
        bg = Colors.orange.shade400;
        textC = Colors.white;
        label = 'To-do';
        break;
    }


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(color: textC, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}