import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    title: Text(
      'Export Meal Plan',
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Select Time Range',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _toggleButton('Today', Icons.today),
            const SizedBox(width: 8),
            _toggleButton('This Week', Icons.calendar_view_week),
          ],
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Export Format',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
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
            backgroundColor: Color.fromARGB(255, 202, 24, 60) ,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              const Icon(Icons.download, color: Colors.white),
              const SizedBox(width: 8),
              Text(
                'Export Now',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
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
  return MouseRegion(
    onEnter: (_) => setState(() => selectedTime = label),
    child: SizedBox(
      width: 120,
      height: 76,
      child: OutlinedButton(
        onPressed: () => setState(() => selectedTime = label),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isSelected ? Color.fromARGB(255, 202, 24, 60) : const Color.fromARGB(255, 142, 138, 138),
          ),
          backgroundColor: isSelected ? const Color.fromARGB(255, 239, 246, 255) : Color.fromARGB(255, 249, 250, 251),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ? Color.fromARGB(255, 202, 24, 60) : const Color.fromARGB(255, 32, 37, 46)),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: isSelected ? Color.fromARGB(255, 202, 24, 60) : const Color(0xFF5A5555),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _formatButton(String label, IconData icon) {
  final isSelected = selectedFormat == label;
  return MouseRegion(
    onEnter: (_) => setState(() => selectedFormat = label),
    child: SizedBox(
      width: 120,
      height: 76,
      child: OutlinedButton(
        onPressed: () => setState(() => selectedFormat = label),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isSelected ? Color.fromARGB(255, 202, 24, 60)  : const Color.fromARGB(255, 142, 138, 138),
          ),
          backgroundColor: isSelected ? const Color(0xFFFFE5E5) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isSelected ?Color.fromARGB(255, 202, 24, 60)  : const Color(0xFF5A5555)),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: isSelected ?Color.fromARGB(255, 202, 24, 60)  : const Color(0xFF5A5555),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


}
