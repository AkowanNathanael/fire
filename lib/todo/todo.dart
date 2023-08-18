import 'package:flutter/material.dart';

import "package:fire/components.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Todo App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: TodoScreen(),
//     );
//   }
// }

class Todo {
  final String title;
  final bool completed;

  Todo({
    required this.title,
    this.completed = false,
  });
}

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void toggleCompleted(int index) {
    final todo = _todos[index];
    _todos[index] = Todo(
      title: todo.title,
      completed: !todo.completed,
    );
    notifyListeners();
  }

  void removeCompleted() {
    _todos.removeWhere((todo) => todo.completed);
    notifyListeners();
  }

  List<Todo> filterTodos(String searchQuery) {
    return _todos.where((todo) {
      final todoTitle = todo.title.toLowerCase();
      final query = searchQuery.toLowerCase();
      return todoTitle.contains(query);
    }).toList();
  }
}

final todoListProvider = ChangeNotifierProvider((ref) => TodoList());

class TodoScreen extends ConsumerWidget {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                ref.read(todoListProvider).removeCompleted();
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  // Trigger filtering when the search query changes
                  ref.read(todoListProvider).notifyListeners();
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, watch, child) {
                  final todos = ref
                      .watch(todoListProvider)
                      .filterTodos(searchController.text);
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return ListTile(
                        leading: Checkbox(
                          value: todo.completed,
                          onChanged: (_) {
                            ref.read(todoListProvider).toggleCompleted(index);
                          },
                        ),
                        title: Text(todo.title),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        // ...existing code...

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final TextEditingController newTodoController =
                    TextEditingController();
                return AlertDialog(
                  title: Text('Add Todo'),
                  content: TextField(
                    controller: newTodoController,
                    decoration: InputDecoration(
                      labelText: 'Todo',
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () {
                        final String newTodoTitle = newTodoController.text;
                        if (newTodoTitle.isNotEmpty) {
                          ref.read(todoListProvider).addTodo(
                                Todo(
                                  title: newTodoTitle,
                                ),
                              );
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
