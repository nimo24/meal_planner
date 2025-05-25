import 'package:hive/hive.dart';
import 'meal_model.dart';

part 'ScheduledMeal.g.dart';

@HiveType(typeId: 2)
class ScheduledMeal extends HiveObject {
  @HiveField(0)
  DateTime date; // Includes day, month, year

  @HiveField(1)
  String mealType; // "Breakfast", "Lunch", "Dinner"

  @HiveField(2)
  Meal meal; // Reference to the Meal itself

  ScheduledMeal({
    required this.date,
    required this.mealType,
    required this.meal,
  });
}
