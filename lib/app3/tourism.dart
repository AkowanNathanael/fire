// ignore_for_file: unrelated_type_equality_checks, avoid_print

import 'package:fire/app3/hotlines.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'package:fire/app3/tours.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  // String _policenumber = "";
  // String _policeemail = "";
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: "danyonathaniel7@gmail.com",
      queryParameters: {'subject': "Police Report"},
    );
    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const MakeComplain();
                          }));
                        },
                        child: const Text("Book a bus")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const Hotlines();
                          }));
                        },
                        child: const Text("Hotlines")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return ScreenA();
                          }));
                        },
                        child: const Text("Tour Area")),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class MakeComplain extends StatefulWidget {
  const MakeComplain({super.key});

  @override
  State<MakeComplain> createState() => _MakeComplainState();
}

class _MakeComplainState extends State<MakeComplain> {
  // File? _image;
  // final picker = ImagePicker();
  // final namecontroller = TextEditingController();
  // Future chooseImage() async {
  //   var pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(pickedImage!.path);
  //   });
  // }

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _seats = TextEditingController();
  final TextEditingController _departure = TextEditingController();
  final TextEditingController _destination = TextEditingController();
  final TextEditingController _message = TextEditingController();
  final TextEditingController _startdestination = TextEditingController();
  final TextEditingController _contact = TextEditingController();

  Future<void> Savedata() async {
    if (_name != "" &&
        _email != "" &&
        _seats != "" &&
        _selectedDate.toString() != "" &&
        _destination != "" &&
        _message != "" &&
        _startdestination != "" &&
        _contact != "") {
      var request = await http.post(
          Uri.parse(
              "https://flutter777.000webhostapp.com/app3/save_tourism.php"),
          body: {
            "name": _name.text,
            "email": _email.text,
            "seats": _seats.text,
            "message": _message.text,
            "departure": _selectedDate.toString(),
            "destination": _destination.text,
            "startdestination": _startdestination.text,
            "contact": _contact.text,
          });

      print(request.body);
      if (request.statusCode == 200) {
        // ignore: avoid_print
        print("image uploaded");
      } else {
        print("image not uploaded");
      }
      _name.clear();
      _email.clear();
      _seats.clear();
      _message.clear();
      _destination.clear();
      // _departure.clear();
      _startdestination.clear();
      _contact.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Request sent successfully, we will get back to you")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Fileds cannot be blank")));
    }
  }

  DateTime _selectedDate = DateTime.now();
  // TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        print(_selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Make A bus Request"),
      ),
      body: ListView(children: [
        TextField(
          controller: _name,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Sender Name"),
              hintText: "enter name"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        TextField(
          controller: _email,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Email"),
              hintText: "enter email"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        TextField(
          controller: _seats,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("No of seats"),
              hintText: "enter seats"),
          keyboardType: TextInputType.number,
          // maxLines: 2,
        ),
        TextField(
          controller: _destination,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Destination"),
              hintText: "enter destination"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        // TextField(
        //   controller: _departure,
        //   decoration: InputDecoration(
        //       hoverColor: Colors.green[200],
        //       focusColor: Colors.amberAccent[300],
        //       label: const Text("Daparture Date"),
        //       hintText: "enter departure date"),
        //   keyboardType: TextInputType.datetime,
        //   // maxLines: 2,
        // ),
        TextButton(
          child: const Text("Choose Depature Date"),
          onPressed: () {
            setState(() {
              _selectDate(context);
            });
          },
        ),
        TextField(
          controller: _startdestination,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Start Destination"),
              hintText: "enter destination"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        TextField(
          controller: _contact,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Sender contact"),
              hintText: "enter phone numer eg 0206878947"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        TextField(
          controller: _message,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Message"),
              hintText: "enter message"),
          keyboardType: TextInputType.name,
          maxLines: 2,
          maxLength: 5000,
        ),
        // Container(
        //     width: 200,
        //     height: 200,
        //     child: _image == null
        //         ? Center(child: const Text("no image"))
        //         : Image.file(_image!)),
        // TextButton(
        //     onPressed: () {
        //       chooseImage();
        //     },
        //     child: const Text("Select Image")),
        TextButton(
            onPressed: () {
              Savedata();
            },
            child: const Text("Make a request")),
      ]),
    );
  }
}
