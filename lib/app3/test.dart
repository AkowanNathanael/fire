// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future login(BuildContext context) async {
    try {
      Fluttertoast.showToast(msg: "wait a minute");
      // var url = Uri.https('example.com', '/api/v1/users');
      // http://192.168.151.47:8383/flutter/app1/login.php
      var url =
          Uri.parse("https://flutter777.000webhostapp.com/app1/login.php");
      // var url = "https://flutter777.000webhostapp.com/app1/login.php";
      // Uri.parse(url)
      var res = await http.post(url, body: {
        // "username": _usernameController.text,
        "email": _emailController.text,
        "password": _passwordController.text
      });
      print(res.body);
      print(res.statusCode);
      var data = jsonDecode(res.body);
      if (data == "success") {
        Fluttertoast.showToast(msg: "login success");
        // Future.delayed(const Duration(seconds: 1));
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const SignupPage();
        }));
      } else {
        Fluttertoast.showToast(msg: "login failed");
      }

      _emailController.clear();
      _passwordController.clear();
      // _usernameController.clear();
    } catch (e, trace) {
      Fluttertoast.showToast(msg: ' error ${e.toString()}  trace ${trace}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: 'Email', suffixIcon: Icon(Icons.email))),
            TextField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                // textInputAction: TextInputAction.,
                decoration: const InputDecoration(
                    labelText: 'Password',
                    suffixIcon: Icon(Icons.safety_check))),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement login logic using DatabaseHelper
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //   return const Menu();
                // }));
                login(context);
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement login logic using DatabaseHelper
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return SignupPage();
                }));
              },
              child: const Text('register'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
