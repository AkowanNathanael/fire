import 'package:flutter/material.dart';
// import 'dart:convert';

// @immutable
// class User {
//   String? UserId;
//   String? id;
//   String? title;
//   String? body;
//   User(
//       {required this.UserId,
//       required this.id,
//       required this.title,
//       required this.body});

//   User copyWith({String? UserId, String? id, String? title, String? body}) {
//     return User(
//         UserId: UserId ?? this.UserId,
//         id: id ?? this.id,
//         title: title ?? this.title,
//         body: body ?? this.body);
//   }

//   factory User.fromJson(String json) {
//     Map<String, dynamic> parsedJson = jsonDecode(json);
//     return User(
//       UserId: parsedJson["UserId"] as String?,
//       id: parsedJson["id"] as String,
//       title: parsedJson["title"] as String?,
//       body: parsedJson["body"] as String?,
//     );
//   }
// }