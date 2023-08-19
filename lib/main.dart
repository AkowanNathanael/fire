// ignore_for_file: depend_on_referenced_packages

// import 'package:fire/pod/app.dart';
import 'package:fire/app3/mysplash.dart';
import 'package:flutter/material.dart';
// import 'package:fire/php/screen.dart';
// import 'package:fire/all/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fire/do/models.dart';
import "package:shared_preferences/shared_preferences.dart";

Future mydark() async {
  final darkmodepref = await SharedPreferences.getInstance();
  final darkpref = darkmodepref.getBool("darkmode");
  return darkpref;
}

// bool darkpref=darkmodepref.
final darkmodeprov = StateProvider((ref) => mydark());

void main() {
  // runApp(const MyApp());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final darkpref =  SharedPreferences.getInstance();
    // darkpref.getBool("darkmode");
    final darkpref = ref.watch(darkmodeprov);
    final isdark = ref.watch(isDarkmodeprovider.select((value) => value));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // darkTheme: ThemeData.dark(),
      // theme: isdark ? ThemeData.light() : ThemeData.dark(),
      // themeMode: ThemeMode.dark,

      theme: ThemeData(useMaterial3: true
          // This is
          // primarySwatch: Colors.blue,
          ),
      // home: Home(),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
