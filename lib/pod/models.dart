import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class User {
  String? UserId;
  String? id;
  String? title;
  String? body;
  User(
      {required this.UserId,
      required this.id,
      required this.title,
      required this.body});

  User copyWith({String? UserId, String? id, String? title, String? body}) {
    return User(
        UserId: UserId ?? this.UserId,
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body);
  }

  factory User.fromJson(String json) {
    Map<String, dynamic> parsedJson = jsonDecode(json);
    return User(
      UserId: parsedJson["UserId"] as String?,
      id: parsedJson["id"] as String,
      title: parsedJson["title"] as String?,
      body: parsedJson["body"] as String?,
    );
  }
}

class Human {
  String? name;
  String? age;
  String? gender;
  List<Map<String?, dynamic>> friends = [
    {"name": "Nath", "isfav": true}
  ];
  Human(
      {required this.name,
      required this.age,
      required this.gender,
      required this.friends});

  Human copyWith(
      {String? name,
      String? age,
      String? gender,
      List<Map<String?, dynamic>>? friends}) {
    return Human(
        friends: [
          {"name": "Nath", "isfav": true}
        ],
        name: name ?? this.name,
        age: age ?? this.age,
        gender: gender ?? this.gender);
  }
}

class HumanNotifier extends StateNotifier<Human> {
  // HumanNotifier(super.state);
  HumanNotifier(Human state) : super(state);

  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  void changeAge(String age) {
    state = state.copyWith(age: age);
  }

  void changeGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void addFriend(Map<String, dynamic> friend) {
    //  state = state.friends.add(friend);
    state = state.copyWith(friends: [...state.friends, friend]);
  }

  void removeFriend(Map<String, dynamic> friend) {
    //  state = state.friends.add(friend);
    state = state.copyWith(friends: [...state.friends, friend]);
  }
}

// User user = User(age: 12, name: "Kofi");
// user.copyWith();
// ignore: non_constant_identifier_names

