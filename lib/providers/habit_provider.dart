// lib/providers/habit_provider.dart
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  List<Habit> _habits = [];
  Box<Habit>? _habitBox;

  List<Habit> get habits => _habits;

  Future<void> loadHabits() async {
    _habitBox = await Hive.openBox<Habit>('habitsBox');
    _habits = _habitBox!.values.toList();
    notifyListeners();
  }

  Future<void> addHabit(Habit habit) async {
    await _habitBox!.put(habit.id, habit);
    _habits = _habitBox!.values.toList();
    notifyListeners();
  }

  Future<void> updateHabit(Habit habit) async {
    await habit.save();
    _habits = _habitBox!.values.toList();
    notifyListeners();
  }

  Future<void> deleteHabit(Habit habit) async {
    await habit.delete();
    _habits.remove(habit);
    notifyListeners();
  }

  Future<void> toggleComplete(Habit habit) async {
    habit.completedToday = !habit.completedToday;
    if (habit.completedToday) {
      habit.exp += 10;
      habit.streak += 1;
    }
    await habit.save();
    notifyListeners();
  }
}
