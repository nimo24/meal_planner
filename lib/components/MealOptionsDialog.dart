import 'package:flutter/material.dart';

class MealOptionsDialog extends StatelessWidget {
  const MealOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Meal Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _optionTile(Icons.refresh, 'Replace Meal', () {}, iconColor: const Color.fromARGB(255, 63, 106, 193)),
          const SizedBox(height: 8),
          _optionTile(Icons.edit, 'Modify Meal', () {}, iconColor: const Color.fromARGB(255, 117, 28, 133)),
          const SizedBox(height: 8),
          _optionTile(Icons.delete, 'Delete Meal', () {}, iconColor: const Color.fromARGB(255, 192, 46, 35), textColor: const Color.fromARGB(255, 192, 46, 35)),
        ],
      ),
    );
  }

  Widget _optionTile(IconData icon, String label, VoidCallback onTap, {Color? iconColor, Color? textColor}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? Colors.black),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(color: textColor ?? Colors.black)),
          ],
        ),
      ),
    );
  }
}
