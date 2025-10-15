// lib/models/habit.dart
import 'package:hive/hive.dart';

part 'habit.g.dart'; // để Hive tạo adapter

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  int streak; // số ngày liên tiếp

  @HiveField(4)
  int exp; // điểm kinh nghiệm nhận được

  @HiveField(5)
  bool completedToday;

  Habit({
    required this.id,
    required this.name,
    this.description = '',
    this.streak = 0,
    this.exp = 0,
    this.completedToday = false,
  });
}
