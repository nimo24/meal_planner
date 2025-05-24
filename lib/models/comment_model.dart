import 'package:hive/hive.dart';

part 'comment_model.g.dart';

@HiveType(typeId: 1)
class Comment extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  String mealId; // <-- Add this field to track which meal the comment is for

  Comment(this.text, this.mealId);
}
