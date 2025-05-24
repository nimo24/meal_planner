// calendar_popup.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPopup extends StatefulWidget {
  final void Function(DateTime, String) onValidate;

  const CalendarPopup({Key? key, required this.onValidate}) : super(key: key);

  @override
  _CalendarPopupState createState() => _CalendarPopupState();
}
class _CalendarPopupState extends State<CalendarPopup> {
  DateTime _selectedDay = DateTime.now();
  String _selectedMeal = 'Breakfast';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choose a date and meal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Calendar
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _selectedDay,
              selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() => _selectedDay = selectedDay);
              },
            ),
            const SizedBox(height: 16),

            // Meal selection buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['Breakfast', 'Lunch', 'Dinner'].map((meal) {
                final isSelected = _selectedMeal == meal;
                return ElevatedButton(
                  onPressed: () {
                    setState(() => _selectedMeal = meal);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.teal : Colors.grey[300],
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: isSelected ? 3 : 0,
                  ),
                  child: Text(meal),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // Validate button
            ElevatedButton.icon(
              onPressed: () {
                widget.onValidate(_selectedDay, _selectedMeal);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.check),
              label: const Text("Validate"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
