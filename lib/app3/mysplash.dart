import 'package:fire/app3/tourism.dart';
import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _anime =
      AnimationController(duration: const Duration(seconds: 2), vsync: this)
        ..repeat();
  late final Animation<double> _animation =
      CurvedAnimation(parent: _anime, curve: Curves.bounceInOut);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const Screen();
      }));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.red),
                  borderRadius: BorderRadius.circular(30)),
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Mobile  Computing Project",
                        style: TextStyle(fontSize: 23),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "GROUP 17",
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Center(
                        child: Text(
                          "Book a Bus For Your Tour",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),

                    // AnimatedTextKit(repeatForever: true, animatedTexts: [
                    //   // WavyAnimatedText("GROUP 36",
                    //   //     // speed: const Duration(microseconds: 200),
                    //   //     textStyle: const TextStyle(fontSize: 30)),
                    //   // TypewriterAnimatedText('Police Reporting System',
                    //   //     speed: const Duration(milliseconds: 100),
                    //   //     textStyle: const TextStyle(
                    //   //       fontSize: 27.0,
                    //   //       fontWeight: FontWeight.bold,
                    //   //     )),
                    // ]),
                    SizedBox(
                      height: 50,
                    ),
                    // RotationTransition(
                    //   turns: _animation,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(5),
                    //     child: Wrap(
                    //       children: [
                    //         Container(
                    //           width: 30,
                    //           height: 40,
                    //           color: Colors.red,
                    //         ),
                    //         Container(
                    //           width: 60,
                    //           height: 40,
                    //           decoration: const BoxDecoration(
                    //               color: Colors.red, shape: BoxShape.circle),
                    //         ),
                    //         Container(
                    //           width: 60,
                    //           height: 40,
                    //           decoration: const BoxDecoration(
                    //               color: Color.fromARGB(255, 197, 216, 74),
                    //               shape: BoxShape.circle),
                    //         ),
                    //         Container(
                    //           width: 30,
                    //           height: 40,
                    //           decoration: const BoxDecoration(
                    //               color: Color.fromARGB(255, 54, 244, 67),
                    //               shape: BoxShape.circle),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.red),
                borderRadius: BorderRadius.circular(20)),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Group Members", style: TextStyle(fontSize: 30)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("ID: FMS/0050/19 "),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("ID: 20200404138 "),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(" ID: 20200404018 "),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(" ID FMS/0124/19 "),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(" ID: FMS/0198/19 "),
          ),
          MaterialButton(
              color: Colors.amber[200],
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return Menu();
                }));
              },
              child: const Text("Proceed"))
        ]),
      ),
    );
  }
}
