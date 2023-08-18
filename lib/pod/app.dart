// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './models.dart';
import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

// providers
final apptextProv = Provider<String>((ref) => "App Crave");
final nameProv = StateProvider((ref) => "");
final passProv = StateProvider((ref) => "");

class App extends ConsumerWidget {
  App({super.key});

  @override
  final nameController = TextEditingController();
  final passController = TextEditingController();
  Widget build(BuildContext context, WidgetRef ref) {
    final apptext = ref.watch(apptextProv);
    final name = ref.watch(nameProv);
    final pass = ref.watch(passProv);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(apptext),
        ),
        body: Column(
          children: [
            Text("name : $name"),
            const SizedBox(
              height: 20,
            ),
            Text("password : $pass"),
            const SizedBox(
              height: 20,
            ),
            const Text("hi"),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                    iconColor: Colors.red,
                    icon: Icon(Icons.people),
                    focusColor: Colors.red,
                    hoverColor: Colors.blueAccent,
                    label: Text("username")),
                keyboardType: TextInputType.text,
                controller: nameController,
                onSubmitted: (val) {
                  ref.read(nameProv.notifier).update((state) => val);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                    iconColor: Colors.red,
                    icon: Icon(Icons.password),
                    focusColor: Colors.red,
                    hoverColor: Colors.blueAccent,
                    label: Text("password")),
                keyboardType: TextInputType.text,
                controller: passController,
                onSubmitted: (val) {
                  ref.read(passProv.notifier).update((state) => val);
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            MaterialButton(
              focusColor: Colors.black,
              elevation: 10,
              minWidth: 300,
              color: Colors.pink,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const User();
                }));
              },
              child: const Text("User"),
            )
          ],
        ));
  }
}

// providers
final UserProve = StateNotifierProvider<HumanNotifier, Human>((ref) =>
    HumanNotifier(Human(name: "Kim", age: "23", gender: "male", friends: [
      {"name": "Jmaes", "isfav": true},
      {"name": "Kal", "isfav": false},
      {"name": "Yuna", "isfav": true},
      {"name": "Funa", "isfav": true}
    ])));

class User extends ConsumerWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(UserProve);
    return Scaffold(
      appBar: AppBar(
        title: const Text("User"),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.name.toString(),
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.age.toString(),
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.gender.toString(),
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
              color: const Color.fromARGB(255, 37, 163, 226),
              elevation: 10,
              minWidth: 70,
              textColor: Colors.red,
              colorBrightness: Brightness.dark,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext contxt) {
                  return const Friends();
                }));
              },
              child: const Text(
                "Firends",
                style: TextStyle(fontSize: 30),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const MyFuture();
                }));
              },
              child: const Text("Future"))
        ],
      ),
    );
  }
}

// providers
final myStateProve = StateProvider((ref) => 0);

class Friends extends ConsumerWidget {
  const Friends({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(UserProve);
    final number = ref.watch(myStateProve);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends"),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
          itemCount: user.friends.length,
          itemBuilder: (BuildContext context, index) {
            // ignore: avoid_unnecessary_containers
            return Container(
              child: Row(
                children: [
                  Text(user.friends[index]["name"].toString()),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(user.friends[index]["isfav"].toString()),
                  Switch(
                      value: user.friends[index]["isfav"],
                      onChanged: (val) {
                        user.friends[index]["isfav"] = val;
                        ref
                            .read(myStateProve.notifier)
                            .update((state) => state++);
                        // print(val);
                      })
                ],
              ),
            );
          }),
    );
  }
}

//

final futureprove = FutureProvider((ref) {
  const url = "https://jsonplaceholder.typicode.com/posts";
  final urlData = http.get(Uri.parse(url));
  return urlData;
});

class MyFuture extends ConsumerWidget {
  const MyFuture({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mydata = ref.watch(futureprove);
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyFuturw"),
      ),
      body: SafeArea(
          child: Center(
        child: mydata.when(
            data: (data) {
              final U = jsonDecode(data.body);
              return ListView.separated(
                separatorBuilder: (BuildContext contxt, index) => const Divider(
                  thickness: 3,
                  height: 50,
                ),
                itemCount: U.length,
                itemBuilder: (BuildContext context, index) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(U[index]["userId"].toString()),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(U[index]["id"].toString()),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(U[index]["title"].toString()),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(U[index]["id"].toString())
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, _) {
              return const Center(
                child: Text("eror occured"),
              );
            },
            loading: () => const CircularProgressIndicator()),
      )),
    );
  }
}
