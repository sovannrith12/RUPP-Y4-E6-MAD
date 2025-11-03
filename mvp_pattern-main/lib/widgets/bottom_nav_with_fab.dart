import 'package:flutter/material.dart';

class BottomNavWithFab extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onFabTap;

  BottomNavWithFab({
    required this.currentIndex,
    required this.onTap,
    required this.onFabTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      child: Container(
        height: 64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side icons
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: currentIndex == 0 ? Colors.purple : Colors.grey),
                  onPressed: () => onTap(0),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today, color: currentIndex == 1 ? Colors.purple : Colors.grey),
                  onPressed: () => onTap(1),
                ),
              ],
            ),
            // Right side icons
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.folder, color: currentIndex == 2 ? Colors.purple : Colors.grey),
                  onPressed: () => onTap(2),
                ),
                IconButton(
                  icon: Icon(Icons.people, color: currentIndex == 3 ? Colors.purple : Colors.grey),
                  onPressed: () => onTap(3),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
