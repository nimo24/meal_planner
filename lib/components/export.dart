import 'package:flutter/material.dart';

class ExportPopup extends StatelessWidget {
  const ExportPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Export Meal Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Time Range'),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              const Text('Today'),
            ],
          ),
          Row(
            children: [
              Checkbox(value: true, onChanged: (value) {}),
              const Text('This Week'),
            ],
          ),
          const Divider(),
          const Text('Export Format'),
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(value: false, onChanged: (value) {}),
              const Text('PDF'),
            ],
          ),
          Row(
            children: [
              Checkbox(value: true, onChanged: (value) {}),
              const Text('Image'),
            ],
          ),
          const Divider(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Export Now'),
        ),
      ],
    );
  }
}