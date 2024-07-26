import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class UpdateTodoDialog extends StatefulWidget {
  final DateTime date;
  final int index;
  final Todo todo;

  UpdateTodoDialog({required this.date, required this.index, required this.todo});

  @override
  _UpdateTodoDialogState createState() => _UpdateTodoDialogState();
}

class _UpdateTodoDialogState extends State<UpdateTodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
              Provider.of<TodoProvider>(context, listen: false).updateTodo(
                widget.date,
                widget.index,
                _titleController.text,
                _descriptionController.text,
              );
              Navigator.of(context).pop();
            }
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
