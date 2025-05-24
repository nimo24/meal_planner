import 'package:flutter/material.dart';

class SelectDateDialog extends StatefulWidget {
  const SelectDateDialog({super.key});

  @override
  State<SelectDateDialog> createState() => _SelectDateDialogState();
}

class _SelectDateDialogState extends State<SelectDateDialog> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = 'breakfast';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Select Date'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 420), // 🔧 Limit height
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 250, // 🔧 Fix calendar height
                child: CalendarDatePicker(
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  onDateChanged: (date) => setState(() => selectedDate = date),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Selected Date: ${selectedDate.toLocal().toString().split(' ')[0]}',
              ),
              const SizedBox(height: 8),
              const Text('Select Day Time'),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dayTimeButton('breakfast'),
                  _dayTimeButton('lunch'),
                  _dayTimeButton('dinner'),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text('Validate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayTimeButton(String label) {
    final isSelected = selectedTime == label;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: () => setState(() => selectedTime = label),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.red.shade100 : Colors.white,
          side: BorderSide(color: isSelected ? Colors.red : Colors.grey),
        ),
        child: Text(label),
      ),
    );
  }
}
