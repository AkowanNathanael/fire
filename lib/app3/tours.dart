// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

class ScreenA extends StatelessWidget {
  final List<String> imagePaths = [
    'cape cost_castlePNG.PNG',
    'kintampo_falls.PNG',
    'kakum.PNG',
    'larabanga.PNG',
    'mole_park.PNG',
    'cape cost_castlePNG.PNG',
    'kintampo_falls.PNG'
    // ,
    // 'kakum.PNG',
    // 'cape cost_castlePNG.PNG',
    // 'kintampo_falls.PNG',
    // 'kakum.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen A')),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${imagePaths[index]}"),
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ScreenB(imagePath: imagePaths[index]),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Hero(
                  tag: 'imageTag${imagePaths[index]}',
                  child: Image.asset('assets/${imagePaths[index]}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  final String imagePath;

  ScreenB({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen B')),
      body: Center(
        child: Hero(
          tag: 'imageTag$imagePath',
          child: Image.asset('assets/$imagePath'),
        ),
      ),
    );
  }
}
