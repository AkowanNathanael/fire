import "package:flutter/material.dart";
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Php extends StatefulWidget {
  const Php({super.key});

  @override
  State<Php> createState() => _PhpState();
}

class _PhpState extends State<Php> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Center(
                child: MaterialButton(
                  color: Colors.red,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext c) {
                      return const AllData();
                    }));
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Go",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "helvetica",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              TextButton(
                child: const Text("Add Data"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext) {
                    return const DataAdd();
                  }));
                },
              ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text("Upload Image"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext) {
                    return const MyImagePicker();
                  }));
                },
              ),
              // TextButton(
              //   child: const Text("Add Data"),
              //   onPressed: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (BuildContext) {
              //       return const DataAdd();
              //     }));
              //   },
              // ),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.pink),
                child: const Text("View images"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext) {
                    return const ViewImages();
                  }));
                },
              )
            ],
          ),
        ));
  }
}

class AllData extends StatefulWidget {
  const AllData({super.key});

  @override
  State<AllData> createState() => _AllDataState();
}

class _AllDataState extends State<AllData> {
  var data = [];
  void fetchData() async {
    try {
      final res =
          await http.get(Uri.parse("http://192.168.90.47:8383/flutterapi/"));
      final json = jsonDecode(res.body);
      setState(() {
        data = json;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "data loaded", textColor: Colors.red);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext, i) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(elevation: 5, child: Text(" ${data[i]['name']}")),
        );
      },
      // children: [Text(" $data ")]
    ));
  }
}

class DataAdd extends StatefulWidget {
  const DataAdd({super.key});

  @override
  State<DataAdd> createState() => _DataAddState();
}

class _DataAddState extends State<DataAdd> {
  var res = "";
  final nameCoontroler = TextEditingController();
  void sendData() async {
    // fina
    final response = await http.post(
        Uri.parse("http://192.168.90.47:8383/flutterapi/user_data.php"),
        body: {
          "name": nameCoontroler.text
        },
        headers: {
          // "Content-type": "application/json",
          "Accept": "application/json"
        });
    nameCoontroler.text = "";
    print(response.body);
    setState(() {
      res = response.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameCoontroler,
                  onSubmitted: (value) {
                    sendData();
                  },
                  textInputAction: TextInputAction.send,
                  decoration: const InputDecoration(
                      hintText: "name", label: Text("Name")),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    sendData();
                  },
                  child: const Text("submit")),
            ],
          )
        ],
      ),
    );
  }
}

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({super.key});

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  File? _image;
  final picker = ImagePicker();
  final namecontroller = TextEditingController();
  Future chooseImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  Future uploadImage() async {
    var request = http.MultipartRequest("POST",
        Uri.parse("http://192.168.90.47:8383/flutterapi/upload_image.php"));
    request.fields["name"] = namecontroller.text;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: namecontroller,
              onSubmitted: (value) {
                // sendData();
              },
              textInputAction: TextInputAction.send,
              decoration: const InputDecoration(
                  hintText: "name", label: Text("image name")),
            ),
          ),
          IconButton(
              onPressed: () {
                chooseImage();
              },
              icon: const Icon(Icons.camera)),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            child: _image == null
                ? const Text(
                    "no image selected",
                    style: TextStyle(fontSize: 25),
                  )
                : Image.file(_image!),
          ),
          TextButton(
              onPressed: () {
                uploadImage();
              },
              child: const Text("Upload Image"))
        ],
      ),
    );
  }
}

class ViewImages extends StatefulWidget {
  const ViewImages({super.key});

  @override
  State<ViewImages> createState() => _ViewImagesState();
}

class _ViewImagesState extends State<ViewImages> {
  var data = [];
  void fetchData() async {
    try {
      final res = await http.get(
          Uri.parse("http://192.168.90.47:8383/flutterapi/all_images.php"));
      final json = jsonDecode(res.body);
      setState(() {
        data = json;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "data loaded", textColor: Colors.red);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // super.initState();
    fetchData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Php backend"),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext, int index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: Color.fromARGB(31, 136, 134, 134),
                      blurRadius: 5,
                      spreadRadius: 10),
                  BoxShadow(color: Color.fromARGB(31, 177, 136, 136))
                ],
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),

              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              child: Image.network(
                  "http://192.168.90.47:8383/flutterapi/images/${data[index]['name']}"),
              // Text(" ${data[index]['name']}")
              // Image.network("http://192.168.90.47:8383/flutterapi/images/${}"),
            );
          },
          separatorBuilder: (BuildContext, int index) {
            return const Divider();
          },
          itemCount: data.length),
    );
  }
}
