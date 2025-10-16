import 'package:flutter/material.dart';
import 'package:habit_hero/models/hero_stats.dart';
import 'package:hive/hive.dart';

class HeroProvider extends ChangeNotifier {
  late HeroStats _hero;
  Box<HeroStats>? _heroBox;
  bool _isLoaded = false;

  HeroStats get hero => _hero;
  bool get isLoaded => _isLoaded;

  Future<void> loadHero() async {
    if (_isLoaded) return; // Prevent reloading
    _heroBox = await Hive.openBox<HeroStats>('heroBox');
    if(_heroBox!.isEmpty){
      print("No hero stats found in the database. Initializing new hero stats.");
      _hero = HeroStats();
      await _heroBox!.put('player', _hero);
    } else {
      _hero = _heroBox!.get('player')!;
    }
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> addExp(int amount) async {
    _hero.addExp(amount);
    await hero.save();
    notifyListeners();
  }

  Future<void> addBadge(String badge) async {
    _hero.badges.add(badge);
    await hero.save();
    notifyListeners();
  }
}