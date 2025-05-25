import 'package:flutter/material.dart';

/*class SelectDateDialog extends StatefulWidget {
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
}*/


import 'package:intl/intl.dart';



class DatePickerMealSelector extends StatefulWidget {
  final Function(DateTime, String) onDateAndMealSelected;

  const DatePickerMealSelector({Key? key, required this.onDateAndMealSelected})
      : super(key: key);

  @override
  _DatePickerMealSelectorState createState() => _DatePickerMealSelectorState();
}

class _DatePickerMealSelectorState extends State<DatePickerMealSelector> {
  DateTime _selectedDate = DateTime.now();
  String _selectedMeal = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Date',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCalendar(),
          const SizedBox(height: 16),
          Text(
            'Selected Date: ${DateFormat('MMMM d, y').format(_selectedDate)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select day time',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          _buildMealButtons(),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 202, 24, 59),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _selectedMeal.isEmpty
                  ? null
                  : () {
                      widget.onDateAndMealSelected(
                          _selectedDate, _selectedMeal);
                    },
              child: const Text('Validate'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    DateTime currentMonth =
        DateTime(_selectedDate.year, _selectedDate.month, 1);
    DateTime previousMonth =
        DateTime(currentMonth.year, currentMonth.month - 1, 1);
    DateTime nextMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 1);

    int daysInMonth =
        DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    int firstWeekdayOfMonth = currentMonth.weekday;

    List<Widget> dayWidgets = [];

    dayWidgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(
                  previousMonth.year,
                  previousMonth.month,
                  _selectedDate.day >
                          DateUtils.getDaysInMonth(
                              previousMonth.year, previousMonth.month)
                      ? DateUtils.getDaysInMonth(
                          previousMonth.year, previousMonth.month)
                      : _selectedDate.day,
                );
              });
            },
          ),
          Text(
            DateFormat('MMMM y').format(currentMonth),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime(
                  nextMonth.year,
                  nextMonth.month,
                  _selectedDate.day >
                          DateUtils.getDaysInMonth(
                              nextMonth.year, nextMonth.month)
                      ? DateUtils.getDaysInMonth(
                          nextMonth.year, nextMonth.month)
                      : _selectedDate.day,
                );
              });
            },
          ),
        ],
      ),
    );

    dayWidgets.add(
      const Row(
        children: [
          Expanded(child: Center(child: Text('Su'))),
          Expanded(child: Center(child: Text('Mo'))),
          Expanded(child: Center(child: Text('Tu'))),
          Expanded(child: Center(child: Text('We'))),
          Expanded(child: Center(child: Text('Th'))),
          Expanded(child: Center(child: Text('Fr'))),
          Expanded(child: Center(child: Text('Sa'))),
        ],
      ),
    );

    int daysFromPreviousMonth = firstWeekdayOfMonth % 7;
    DateTime previousMonthLastDay =
        DateTime(currentMonth.year, currentMonth.month, 0);
    int daysInPreviousMonth = previousMonthLastDay.day;

    for (int i = daysFromPreviousMonth - 1; i >= 0; i--) {
      dayWidgets.add(
        Expanded(
          child: Center(
            child: Text(
              '${daysInPreviousMonth - i}',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
        ),
      );
    }

    for (int day = 1; day <= daysInMonth; day++) {
      bool isSelected =
          day == _selectedDate.day && currentMonth.month == _selectedDate.month;
      dayWidgets.add(
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = DateTime(currentMonth.year,
                    currentMonth.month, day);
              });
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 202, 24, 59)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color.fromARGB(255, 61, 60, 64),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    int totalCells = daysFromPreviousMonth + daysInMonth;
    int remainingCells =
        totalCells % 7 == 0 ? 0 : 7 - (totalCells % 7);

    for (int day = 1; day <= remainingCells; day++) {
      dayWidgets.add(
        Expanded(
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(color: Colors.grey.shade400),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        dayWidgets[0],
        const SizedBox(height: 8),
        dayWidgets[1],
        const SizedBox(height: 8),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 7,
          children: dayWidgets.sublist(2),
        ),
      ],
    );
  }

  Widget _buildMealButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMealButton('Breakfast'),
        _buildMealButton('Lunch'),
        _buildMealButton('Dinner'),
      ],
    );
  }

  Widget _buildMealButton(String meal) {
    bool isSelected = _selectedMeal == meal.toLowerCase();
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xFFF1F6FF),
        foregroundColor: isSelected ? const Color.fromARGB(255, 202, 24, 59) : Colors.black87,
        side: BorderSide(color: isSelected ? const Color.fromARGB(255, 202, 24, 59) : Colors.transparent),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      onPressed: () {
        setState(() {
          _selectedMeal = meal.toLowerCase();
        });
      },
      child: Text(meal.toLowerCase()),
    );
  }
}
