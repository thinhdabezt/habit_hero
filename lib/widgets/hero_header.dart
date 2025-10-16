import 'package:flutter/material.dart';
import 'package:habit_hero/providers/hero_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HeroHeader extends StatelessWidget {
  const HeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final hero = Provider.of<HeroProvider>(context).hero;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Colors.indigo, Colors.deepPurple]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Level ${hero.level}',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
          if (hero.exp == 0) // khi vừa level up
            Center(
              child: SizedBox(
                height: 120,
                child: Lottie.asset(
                  'assets/animations/level_up.json',
                  repeat: false,
                ),
              ),
            ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: hero.exp / hero.expToNextLevel,
            backgroundColor: Colors.white24,
            color: Colors.amber,
            minHeight: 10,
          ),
          const SizedBox(height: 4),
          Text(
            '${hero.exp}/${hero.expToNextLevel} EXP',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.monetization_on, color: Colors.yellow),
              const SizedBox(width: 6),
              Text(
                '${hero.coins} Coins',
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Wrap(
                children: hero.badges
                    .map(
                      (b) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Chip(
                          label: Text(b, style: const TextStyle(fontSize: 12)),
                          backgroundColor: Colors.orange[300],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
