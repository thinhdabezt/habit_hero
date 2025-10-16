// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hero_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HeroStatsAdapter extends TypeAdapter<HeroStats> {
  @override
  final int typeId = 1;

  @override
  HeroStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HeroStats(
      level: fields[0] as int,
      exp: fields[1] as int,
      coins: fields[2] as int,
      badges: (fields[3] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HeroStats obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.exp)
      ..writeByte(2)
      ..write(obj.coins)
      ..writeByte(3)
      ..write(obj.badges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
