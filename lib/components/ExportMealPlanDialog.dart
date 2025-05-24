import 'package:flutter/material.dart';

class ExportMealPlanDialog extends StatefulWidget {
  const ExportMealPlanDialog({super.key});

  @override
  State<ExportMealPlanDialog> createState() => _ExportMealPlanDialogState();
}

class _ExportMealPlanDialogState extends State<ExportMealPlanDialog> {
  String selectedTime = 'Today';
  String selectedFormat = 'PDF';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Export Meal Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text('Select Time Range')),
          const SizedBox(height: 10),
          Row(
            children: [
              _toggleButton('Today', Icons.today),
              const SizedBox(width: 8),
              _toggleButton('This Week', Icons.calendar_view_week),
            ],
          ),
          const SizedBox(height: 20),
          const Align(alignment: Alignment.centerLeft, child: Text('Export Format')),
          const SizedBox(height: 10),
          Row(
            children: [
              _formatButton('PDF', Icons.picture_as_pdf),
              const SizedBox(width: 8),
              _formatButton('Image', Icons.image),
            ],
          ),
          const SizedBox(height: 20),
         ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(181, 210, 51, 51),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  onPressed: () {
    Navigator.of(context).pop();
  },
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Icon(Icons.download, color: Colors.white), // 👈 Icon color
      SizedBox(width: 8),
      Text(
        'Export Now',
        style: TextStyle(color: Colors.white), // 👈 Text color
      ),
    ],
  ),
)

        ],
      ),
    );
  }

 Widget _toggleButton(String label, IconData icon) {
  final isSelected = selectedTime == label;
  return Expanded(
    child: OutlinedButton.icon(
      onPressed: () => setState(() => selectedTime = label),
      icon: Icon(
        icon,
        color: isSelected ? Colors.red : const Color.fromARGB(255, 90, 85, 85),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.red : const Color.fromARGB(255, 90, 85, 85),
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFFFFE5E5) : null,
        side: BorderSide(
          color: isSelected ? Colors.red : const Color.fromARGB(255, 142, 138, 138),
        ),
      ),
    ),
  );
}


Widget _formatButton(String label, IconData icon) {
  final isSelected = selectedFormat == label;
  return Expanded(
    child: OutlinedButton.icon(
      onPressed: () => setState(() => selectedFormat = label),
      icon: Icon(
        icon,
        color: isSelected ? Colors.red : const Color.fromARGB(255, 90, 85, 85),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.red : const Color.fromARGB(255, 90, 85, 85),
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFFFFE5E5) : null, // soft red bg
        side: BorderSide(
          color: isSelected ? Colors.red : const Color.fromARGB(255, 142, 138, 138),
        ),
      ),
    ),
  );
}

}
