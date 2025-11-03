import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelector extends StatelessWidget {
  final List<DateTime> dates;
  final DateTime selected;
  final Function(DateTime) onSelect;

  DateSelector({
    required this.dates,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final d = dates[index];
          final isSelected = d.year == selected.year && d.month == selected.month && d.day == selected.day;
          return GestureDetector(
            onTap: () => onSelect(d),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.purple : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(DateFormat("MMM d").format(d),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[800],
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 6),
                  Text(DateFormat("EEE").format(d),
                      style: TextStyle(
                        color: isSelected ? Colors.white70 : Colors.grey,
                        fontSize: 12,
                      )),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 10),
        itemCount: dates.length,
      ),
    );
  }
}
