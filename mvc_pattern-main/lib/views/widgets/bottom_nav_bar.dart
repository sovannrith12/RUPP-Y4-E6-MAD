import 'package:flutter/material.dart';
class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onCentralTap;

  const AppBottomNavBar({Key? key, required this.currentIndex, required this.onTap, required this.onCentralTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.white, Colors.deepPurple.withOpacity(0.03)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => onTap(0),
              icon: Icon(Icons.list_alt, color: currentIndex == 0 ? Colors.deepPurple : Colors.grey[600]),
            ),
            IconButton(
              onPressed: () => onTap(1),
              icon: Icon(Icons.calendar_today, color: currentIndex == 1 ? Colors.deepPurple : Colors.grey[600]),
            ),
// Central large button
            GestureDetector(
              onTap: onCentralTap,
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                  boxShadow: [BoxShadow(color: Colors.deepPurple.withOpacity(0.3), blurRadius: 10, offset: Offset(0, 4))],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
            IconButton(
              onPressed: () => onTap(3),
              icon: Icon(Icons.insert_drive_file, color: currentIndex == 3 ? Colors.deepPurple : Colors.grey[600]),
            ),
            IconButton(
              onPressed: () => onTap(4),
              icon: Icon(Icons.people, color: currentIndex == 4 ? Colors.deepPurple : Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}