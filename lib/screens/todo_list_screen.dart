import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../update_todo_dialog.dart';
import 'package:intl/intl.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Todo List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final date = todoProvider.todos.keys.elementAt(index);
              final todos = todoProvider.todos[date]!;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.all(16),
                  title: Text(
                    DateFormat.yMMMd().format(date),
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  children: todos.map((todo) {
                    return ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          color: todo.isDone ? Colors.grey : Colors.black,
                          decoration: todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(todo.description, style: TextStyle(color: Colors.black54)),
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (value) {
                          todoProvider.toggleTodoStatus(date, todos.indexOf(todo));
                        },
                        activeColor: Colors.deepPurple,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.deepPurple),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => UpdateTodoDialog(
                                  date: date,
                                  index: todos.indexOf(todo),
                                  todo: todo,
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteConfirmationDialog(context, todoProvider, date, todos.indexOf(todo));
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context, TodoProvider todoProvider, DateTime date, int todoIndex) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Todo'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this todo item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                todoProvider.deleteTodo(date, todoIndex);
                Navigator.of(context).pop(); // dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
