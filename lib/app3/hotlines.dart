import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
// import 'package:image_picker/image_picker.dart';

class Hotlines extends StatefulWidget {
  const Hotlines({super.key});

  @override
  State<Hotlines> createState() => _HotlinesState();
}

class _HotlinesState extends State<Hotlines> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(),
        body: Container(
          color: Colors.purpleAccent,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    _makePhoneCall("+233555187831");
                  },
                  child: const Text("Call Line1")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    _makePhoneCall("+233555187831");
                  },
                  child: const Text("Call Line2")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                  onPressed: () {
                    _makePhoneCall("111");
                  },
                  child: const Text("Call Line 3")),
            ),
          ]),
        ));
  }
}
