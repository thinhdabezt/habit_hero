// lib/providers/habit_provider.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habit_hero/providers/auth_provider.dart';
import 'package:habit_hero/providers/hero_provider.dart';
import 'package:habit_hero/services/firestore_service.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  List<Habit> _habits = [];
  Box<Habit>? _habitBox;
  bool _isLoaded = false;
  final FirestoreService _firestore = FirestoreService();

  List<Habit> get habits => _habits;
  bool get isLoaded => _isLoaded;

  Future<void> loadHabits(BuildContext context) async {
    if (_isLoaded) return; // Prevent reloading
    _habitBox = await Hive.openBox<Habit>('habitsBox');

    // If local box is empty, fetch from Firestore and populate local box
    if (_habitBox!.isEmpty) {
      final uid = Provider.of<AuthProvider>(context, listen: false).user?.uid;
      if (uid != null) {
        final cloudHabits = await _firestore.fetchHabits(uid);
        for (final h in cloudHabits) {
          await _habitBox!.put(h.id, h);
        }
      }
    }

    _habits = _habitBox!.values.toList();
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> addHabit(Habit habit, {required String uid}) async {
    await _habitBox!.put(habit.id, habit);
    await _firestore.saveHabit(uid, habit);
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

  Future<void> toggleComplete(Habit habit, context) async {
    final uid = Provider.of<AuthProvider>(context,listen: false).user!.uid;
    habit.completedToday = !habit.completedToday;
    if (habit.completedToday) {
      habit.exp += 10;
      habit.streak += 1;

      Provider.of<HeroProvider>(context, listen: false).addExp(10);

      if(habit.streak == 7){
        Provider.of<HeroProvider>(context, listen: false).addBadge('7-day Streak');
      }
    }
    await habit.save();
    await _firestore.saveHabit(uid, habit);
    notifyListeners();
  }
}
