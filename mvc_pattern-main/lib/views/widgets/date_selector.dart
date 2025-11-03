// date_selector.dart
import 'package:flutter/material.dart';

class DateSelector extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime selected;
  final ValueChanged<DateTime> onSelect;
  final String Function(DateTime)? displayDate; // optional formatter

  const DateSelector({
    super.key,
    required this.dates,
    required this.selected,
    required this.onSelect,
    this.displayDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: dates.length,
        itemBuilder: (_, i) {
          final date = dates[i];
          final isSelected = date == selected;

          String text = displayDate != null
              ? displayDate!(date)
              : '${date.day}'; // default shows only day

          return GestureDetector(
            onTap: () => onSelect(date),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.deepPurple : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: isSelected
                    ? [BoxShadow(color: Colors.deepPurple.withOpacity(0.12), blurRadius: 8)]
                    : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
              ),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
