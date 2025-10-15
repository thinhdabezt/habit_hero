// lib/widgets/add_habit_dialog.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';

class AddHabitDialog extends StatefulWidget {
  const AddHabitDialog({super.key});

  @override
  State<AddHabitDialog> createState() => _AddHabitDialogState();
}

class _AddHabitDialogState extends State<AddHabitDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HabitProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Thêm thói quen mới'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Tên thói quen'),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'Mô tả'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Hủy'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('Thêm'),
          onPressed: () {
            if (_nameController.text.isEmpty) return;
            final newHabit = Habit(
              id: const Uuid().v4(),
              name: _nameController.text,
              description: _descController.text,
            );
            provider.addHabit(newHabit);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
