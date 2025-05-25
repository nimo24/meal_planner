import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      backgroundColor: Colors.white, // Set popup background to white
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

            // Scrollable meal selection buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['Breakfast', 'Lunch', 'Dinner'].map((meal) {
                  final isSelected = _selectedMeal == meal;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() => _selectedMeal = meal);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor:
                            isSelected ? Color.fromARGB(255, 219, 234, 254) : Color.fromARGB(255, 219, 234, 254),
                        foregroundColor:
                            isSelected ? Colors.red[800] : Colors.black,
                        side: BorderSide(
                          color: isSelected ? Colors.red : const Color.fromARGB(0, 158, 158, 158),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                       child: Text(
                        meal,
                        style: GoogleFonts.poppins(fontSize: 14,),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Validate button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      widget.onValidate(_selectedDay, _selectedMeal);
                      Navigator.of(context).pop();
                    },
                   
                    label: const Text("Validate"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 202, 24, 60),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
