import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habit_hero/models/habit.dart';
import 'package:habit_hero/models/hero_stats.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  Future<void> saveHabit(String uid, Habit habit) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('habits')
        .doc(habit.id)
        .set({
          'name': habit.name,
          'description': habit.description,
          'streak': habit.streak,
          'exp': habit.exp,
          'completedToday': habit.completedToday,
        });
  }

  Future<void> saveHero(String uid, HeroStats hero) async {
    await _db.collection('users').doc(uid).collection('stats').doc('hero').set({
      'level': hero.level,
      'exp': hero.exp,
      'coins': hero.coins,
      'badges': hero.badges,
    });
  }

  Future<List<Habit>> fetchHabits(String uid) async {
    final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('habits')
        .get();
    return snapshot.docs
        .map(
          (doc) => Habit(
            id: doc.id,
            name: doc['name'],
            description: doc['description'],
            streak: doc['streak'],
            exp: doc['exp'],
            completedToday: doc['completedToday'],
          ),
        )
        .toList();
  }
}
