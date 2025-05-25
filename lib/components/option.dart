import 'package:flutter/material.dart';

class MealCardOptionsPopup extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MealCardOptionsPopup({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Meal Options'),
      children: [
        SimpleDialogOption(
          onPressed: onEdit,
          child: const Text('Edit Meal'),
        ),
        SimpleDialogOption(
          onPressed: onDelete,
          child: const Text('Remove Meal'),
        ),
      ],
    );
  }
}
