import 'package:flutter/material.dart';
import "package:fire/components.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fire/do/models.dart';
import 'package:fluttertoast/fluttertoast.dart';

final todosNotofier = StateNotifierProvider((ref) => TodoNotifier());

class AllDos extends ConsumerStatefulWidget {
  const AllDos({super.key});

  @override
  ConsumerState<AllDos> createState() => _AllDosState();
}

class _AllDosState extends ConsumerState<AllDos> {
  TextEditingController? c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosNotofier);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Todos"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            InputText(
                c: c,
                name: "enter todo",
                label: "todo",
                onchanged: (val) => {
                      Fluttertoast.showToast(
                          msg: "to do added", backgroundColor: Colors.pink),
                      setState(() {
                        c?.text = "";
                      }),
                      ref
                          .read(todosNotofier.notifier)
                          .addTodo(Todo(isfav: false, todo: val.toString()))
                    }),
          ],
        ));
  }
}

//
class Do extends ConsumerStatefulWidget {
  const Do({super.key});

  @override
  ConsumerState<Do> createState() => _DoState();
}

class _DoState extends ConsumerState<Do> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todosNotofier) as List;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return const AllDos();
            }));
          },
          child: const CircleAvatar(
            child: Center(child: Text("+add")),
          ),
        ),
        appBar: AppBar(
          title: const Text("Todos"),
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: ListTile(
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            Fluttertoast.showToast(
                                msg: " ${todos[index].todo} is removed");
                          });
                          ref
                              .read(todosNotofier.notifier)
                              .removeTodo(todos[index]);
                        },
                        icon: const Icon(Icons.delete)),
                    leading: todos[index].isfav
                        ? IconButton(
                            onPressed: () {
                              ref.read(todosNotofier.notifier).updateIsfav(
                                  todos[index], !todos[index].isfav);
                            },
                            icon: const Icon(
                              Icons.favorite_outline_rounded,
                              color: Colors.red,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              ref.read(todosNotofier.notifier).updateIsfav(
                                  todos[index], !todos[index].isfav);
                            },
                            icon: const Icon(
                              Icons.favorite_outline_rounded,
                            )),
                    title: Text(todos[index].todo.toString()),
                  ),
                );
              }),
        ));
  }
}
