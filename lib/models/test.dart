// lib/models/test_model.dart
import 'package:hive/hive.dart';
part 'test.g.dart';

@HiveType(typeId: 1)
class TestModel extends HiveObject {
  @HiveField(0)
  String name;

  TestModel({required this.name});
}
