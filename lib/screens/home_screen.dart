// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:habit_hero/providers/hero_provider.dart';
import 'package:habit_hero/widgets/hero_header.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_tile.dart';
import '../widgets/add_habit_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitProvider>(context);
    final heroProvider = Provider.of<HeroProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Hero'),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder(
        future: Future.wait([
          habitProvider.loadHabits(),
          heroProvider.loadHero(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final habits = habitProvider.habits;

          return Column(
            children: [
              const HeroHeader(),
              Expanded(
                child: habits.isEmpty
                    ? const Center(child: Text('Chưa có thói quen nào 😄'))
                    : ListView.builder(
                        itemCount: habits.length,
                        itemBuilder: (context, index) {
                          final habit = habits[index];
                          return HabitTile(habit: habit);
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(context: context, builder: (_) => const AddHabitDialog());
        },
      ),
    );
  }
}
