import 'package:fire/chart/chart.dart';
import 'package:fire/pod/app.dart';
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import '../php/screen.dart';
import 'package:fire/user/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fire/do/models.dart';
import 'package:fire/do/do.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final isdark = ref.watch(isDarkmodeprovider);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const Php();
                }));
              },
              child: const Text("Php Api")),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const Users();
                }));
              },
              child: const Text("User")),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const Do();
                }));
              },
              child: const Text("Todo")),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const Mycharts();
                }));
              },
              child: const Text("Fl cahrts")),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Dark Mode"),
              IconButton(
                  padding: const EdgeInsets.all(10),
                  color: Colors.pink,
                  // style: IconButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    ref
                        .read(isDarkmodeprovider.notifier)
                        .update((state) => !state);
                    setState(() async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("darkmode", ref.watch(isDarkmodeprovider));
                    });
                    // setState(() {
                    //   ref
                    //       .read(isDarkmodeprovider.notifier)
                    //       .update((state) => !state);
                    // });
                    Fluttertoast.showToast(msg: " dark mode is ${isdark}");
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return const Mycharts();
                    // }));
                  },
                  icon: isdark
                      ? const Icon(Icons.dark_mode)
                      : const Icon(Icons.light_mode)),
            ],
          ),
        )
      ],
    ));
  }
}
