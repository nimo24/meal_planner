import 'package:flutter/material.dart';

// Make sure these dialog widgets are either defined in this file or imported
import 'package:dealy_meal/components/MealOptionsDialog.dart';
import 'package:dealy_meal/components/ExportMealPlanDialog.dart';
import 'package:dealy_meal/components/SelectDateDialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showDialog(BuildContext context, Widget dialog) {
showDialog(
  context: context,
  builder: (BuildContext context) {
    return SelectDateDialog();
  },
);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _showDialog(context, const MealOptionsDialog()),
              child: const Text('Show Meal Options'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showDialog(context, const ExportMealPlanDialog()),
              child: const Text('Show Export Meal Plan'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
  onPressed: () {
    print("SelectDateDialog button pressed");
    _showDialog(context, const SelectDateDialog());
  },
  child: const Text('Show Select Date'),
),
          ],
        ),
      ),
    );
  }
}
