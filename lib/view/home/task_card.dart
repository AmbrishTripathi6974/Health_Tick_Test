import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final int index;
  final bool isChecked;
  final void Function(bool?) onChanged;

  const TaskCard({
    super.key,
    required this.index,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final taskText = "Task ${index + 1}: Complete habit";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: ListTile(
          leading: Checkbox(
            value: isChecked,
            onChanged: onChanged,
            activeColor: Colors.green,
          ),
          title: Text(
            taskText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              decoration: isChecked ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
    );
  }
}
