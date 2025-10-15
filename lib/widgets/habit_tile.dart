// lib/widgets/habit_tile.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;

  const HabitTile({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context, listen: false);
    return Card(
      child: ListTile(
        title: Text(habit.name,
            style: TextStyle(
              decoration: habit.completedToday
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            )),
        subtitle: Text('🔥 Streak: ${habit.streak} | EXP: ${habit.exp}'),
        trailing: IconButton(
          icon: Icon(
            habit.completedToday
                ? Icons.check_circle
                : Icons.circle_outlined,
            color: habit.completedToday ? Colors.green : Colors.grey,
          ),
          onPressed: () => provider.toggleComplete(habit),
        ),
        onLongPress: () => provider.deleteHabit(habit),
      ),
    );
  }
}
