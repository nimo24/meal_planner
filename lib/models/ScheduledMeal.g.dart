// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ScheduledMeal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduledMealAdapter extends TypeAdapter<ScheduledMeal> {
  @override
  final int typeId = 2;

  @override
  ScheduledMeal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduledMeal(
      date: fields[0] as DateTime,
      mealType: fields[1] as String,
      meal: fields[2] as Meal,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduledMeal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.mealType)
      ..writeByte(2)
      ..write(obj.meal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduledMealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
