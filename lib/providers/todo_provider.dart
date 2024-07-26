import 'package:flutter/material.dart';
import '../models/todo.dart';
import 'package:collection/collection.dart';

class TodoProvider with ChangeNotifier {
  Map<DateTime, List<Todo>> _todos = {};

  Map<DateTime, List<Todo>> get todos => _todos;

  void addTodo(String title, String description, DateTime date, bool isComplete) {
    final todo = Todo(
      title: title,
      description: description,
      date: date,
    );

    if (_todos[date] == null) {
      _todos[date] = [];
    }

    _todos[date]!.add(todo);
    notifyListeners();
  }

  void updateTodo(DateTime date, int index, String newTitle, String newDescription) {
    if (_todos[date] != null && _todos[date]!.isNotEmpty) {
      final todo = _todos[date]![index];
      todo.title = newTitle;
      todo.description = newDescription;
      notifyListeners();
    }
  }

  void deleteTodo(DateTime date, int index) {
    if (_todos[date] != null && _todos[date]!.isNotEmpty) {
      _todos[date]!.removeAt(index);
      if (_todos[date]!.isEmpty) {
        _todos.remove(date);
      }
      notifyListeners();
    }
  }

  void toggleTodoStatus(DateTime date, int index) {
    if (_todos[date] != null && _todos[date]!.isNotEmpty) {
      _todos[date]![index].isDone = !_todos[date]![index].isDone;
      notifyListeners();
    }
  }
}
