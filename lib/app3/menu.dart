import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
    // ignore: deprecated_member_use
    // if (await canLaunch(emailUri.toString())) {
    //   // ignore: deprecated_member_use
    //   await launch(emailUri.toString());
    // } else {
    //   // Handle error
    //   throw 'Could not launch email';
    // }
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
                          _makePhoneCall("+233546878947");
                        },
                        child: const Text("Call Police")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          launchEmail();
                        },
                        child: const Text("Email Police")),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const MakeComplain();
                          }));
                        },
                        child: const Text("Make Complain")),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextButton(
                  //       onPressed: () {},
                  //       child: const Text("Add Emergrncy contact")),
                  // )
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
  File? _image;
  final picker = ImagePicker();
  final namecontroller = TextEditingController();
  Future chooseImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  final TextEditingController _title = TextEditingController();
  final TextEditingController _complain = TextEditingController();
  final TextEditingController _loc = TextEditingController();
  final TextEditingController _contact = TextEditingController();

  Future<void> Savedata() async {
    if (_title.text != "" && _complain.text != "" && _loc.text !="" && _contact.text !="") {
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "https://flutter777.000webhostapp.com/app2/save_report.php"));
      // request.fields["name"] = namecontroller.text;
      request.fields["title"] = _title.text;
      request.fields["complain"] = _complain.text;
      request.fields["loc"] = _loc.text;
      request.fields["contact"] = _contact.text;
      var pic = await http.MultipartFile.fromPath("image", _image!.path);
      request.files.add(pic);
      var response = await request.send();

      if (response.statusCode == 200) {
        print("image uploaded");
      } else {
        print("image not uploaded");
      }
      setState(() {
        _image = null;
      });
      _title.clear();
      _complain.clear();
      _loc.clear();
      _contact.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complain sent, Thank you")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("title and complain cannot be empty")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send cmoplain"),
      ),
      body: ListView(children: [
        TextField(
          controller: _title,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Title"),
              hintText: "enter title"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        TextField(
          controller: _loc,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Location"),
              hintText: "enter location"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        TextField(
          controller: _contact,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Sender contact"),
              hintText: "enter phone numer eg 0546878947"),
          keyboardType: TextInputType.name,
          // maxLines: 2,
        ),
        TextField(
          controller: _complain,
          decoration: InputDecoration(
              hoverColor: Colors.green[200],
              focusColor: Colors.amberAccent[300],
              label: const Text("Complain"),
              hintText: "enter complain"),
          keyboardType: TextInputType.name,
          maxLines: 2,
          maxLength: 5000,
        ),
        Container(
            width: 200,
            height: 200,
            child: _image == null
                ? Center(child: const Text("no image"))
                : Image.file(_image!)),
        TextButton(
            onPressed: () {
              chooseImage();
            },
            child: const Text("Select Image")),
        TextButton(
            onPressed: () {
              Savedata();
            },
            child: const Text("Send Report")),
      ]),
    );
  }
}
