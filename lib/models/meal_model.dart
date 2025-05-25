// models/meal.dart
import 'package:hive/hive.dart';
part 'meal_model.g.dart';

@HiveType(typeId: 0)
class Meal extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isFavourite;

  @HiveField(4)
  bool isHistory;

  @HiveField(5)
  String photo;

  @HiveField(6)
  String type;

  @HiveField(7)
  String detailedDescription; // New field

  Meal({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavourite,
    required this.isHistory,
    required this.photo,
    required this.type,
    required this.detailedDescription, // Add to constructor
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isFavourite: json['isFavourite'],
        isHistory: json['isHistory'],
        photo: json['photo'],
        type: json['type'],
        detailedDescription: json['detailedDescription'] ?? '', // Optional fallback
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isFavourite': isFavourite,
        'isHistory': isHistory,
        'photo': photo,
        'type': type,
        'detailedDescription': detailedDescription,
      };
}
