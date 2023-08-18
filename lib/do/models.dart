// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  String? todo;
  bool? isfav = false;
  Todo({
    this.todo,
    this.isfav,
  });

  Todo copyWith({
    String? todo,
    bool? isfav,
  }) {
    return Todo(
      todo: todo ?? this.todo,
      isfav: isfav ?? this.isfav,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'todo': todo,
      'isfav': isfav,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todo: map['todo'] != null ? map['todo'] as String : null,
      isfav: map['isfav'] != null ? map['isfav'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Todo(todo: $todo, isfav: $isfav)';

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.todo == todo && other.isfav == isfav;
  }

  @override
  int get hashCode => todo.hashCode ^ isfav.hashCode;
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);
  void addTodo(Todo t) {
    state = [...state, t];
    // state = state.copyWith(todo: t);
  }

  void removeTodo(Todo t) {
    state = [...state.where((element) => element != t)];
    // state = state.copyWith(isfav: t);
  }

  void updateIsfav(Todo oldTodo, bool updatedIsfav) {
    final updated = <Todo>[];
    for (var i = 0; i < state.length; i++) {
      if (state[i] == oldTodo) {
        oldTodo.isfav = updatedIsfav;
        updated.add(oldTodo);
      } else {
        updated.add(state[i]);
      }
    }
    state = updated;
  }
}

final isDarkmodeprovider = StateProvider((ref) => false);
