import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealOptionsDialog extends StatelessWidget {
  final VoidCallback onReplace;
  final VoidCallback onModify;
  final VoidCallback onDelete;

  const MealOptionsDialog({
    super.key,
    required this.onReplace,
    required this.onModify,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Meal Options',
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _optionTile(Icons.refresh, 'Replace Meal', onReplace,
              iconColor: const Color.fromARGB(255, 63, 106, 193)),
          const SizedBox(height: 8),
          _optionTile(Icons.edit, 'Modify Meal', onModify,
              iconColor: const Color.fromARGB(255, 117, 28, 133)),
          const SizedBox(height: 8),
          _optionTile(Icons.delete, 'Delete Meal', onDelete,
              iconColor: const Color.fromARGB(255, 192, 46, 35),
              textColor: const Color.fromARGB(255, 192, 46, 35)),
        ],
      ),
    );
  }

  Widget _optionTile(IconData icon, String label, VoidCallback onTap,
      {Color? iconColor, Color? textColor}) {
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
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: textColor ?? Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
