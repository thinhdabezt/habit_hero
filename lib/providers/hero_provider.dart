import 'package:flutter/material.dart';
import 'package:habit_hero/models/hero_stats.dart';
import 'package:hive/hive.dart';

class HeroProvider extends ChangeNotifier {
  late HeroStats _hero;
  Box<HeroStats>? _heroBox;

  HeroStats get hero => _hero;

  Future<void> loadHero() async {
    _heroBox = await Hive.openBox<HeroStats>('heroBox');
    if(_heroBox!.isEmpty){
      _hero = HeroStats();
      await _heroBox!.put('player', _hero);
    } else {
      _hero = _heroBox!.get('player')!;
    }
    notifyListeners();
  }

  Future<void> addExp(int amount) async {
    _hero.addExp(amount);
    await hero.save();
    notifyListeners();
  }

  Future<void> addBagde(String badge) async {
    _hero.badges.add(badge);
    await hero.save();
    notifyListeners();
  }
}