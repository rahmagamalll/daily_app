// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weekly_statistics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeeklyStatisticsAdapter extends TypeAdapter<WeeklyStatistics> {
  @override
  final int typeId = 2;

  @override
  WeeklyStatistics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeeklyStatistics(
      weekStartDate: fields[0] as String,
      statistics: (fields[1] as Map).cast<String, double>(),
      topHabit: fields[2] as String,
      leastHabit: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeeklyStatistics obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.weekStartDate)
      ..writeByte(1)
      ..write(obj.statistics)
      ..writeByte(2)
      ..write(obj.topHabit)
      ..writeByte(3)
      ..write(obj.leastHabit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklyStatisticsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
