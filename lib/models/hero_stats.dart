import 'package:hive/hive.dart';

part 'hero_stats.g.dart';

@HiveType(typeId: 1)
class HeroStats extends HiveObject {
  @HiveField(0)
  int level;

  @HiveField(1)
  int exp;

  @HiveField(2)
  int coins;

  @HiveField(3)
  List<String> badges;

  HeroStats({
    this.level = 1,
    this.exp = 0,
    this.coins = 0,
    List<String>? badges,
  }) : badges = badges ?? [];

  void addExp(int amount){
    exp += amount;
    if(exp >= expToNextLevel) {
      exp -= expToNextLevel;
      level++;
      coins += 50;
    }
  }

  int get expToNextLevel => 100 + (level - 1) * 20;
}