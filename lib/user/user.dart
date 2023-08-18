// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fire/components.dart';

class User {
  final String? name;
  final String? email;
  User({
    this.name,
    this.email,
  });

  User copyWith({
    String? name,
    String? email,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name, email: $email)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name && other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}

//
class UserNotifier extends StateNotifier<User> {
  UserNotifier() : super(User(name: "", email: ""));
  void updateName(String name) {
    state = state.copyWith(name: name.toString());
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email.toString());
  }
}

//
final userProvider = StateNotifierProvider((ref) => UserNotifier());

class Users extends ConsumerStatefulWidget {
  const Users({super.key});

  @override
  ConsumerState<Users> createState() => _UsersState();
}

class _UsersState extends ConsumerState<Users> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider) as User;
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            SingleChildScrollView(
              child: Row(
                children: [
                  Text(" Name: ${user.name} "),
                  Text(" Email : ${user.email} ")
                ],
              ),
            ),
            InputText(
              key: const Key(""),
              name: "enter name",
              label: "name",
              onchanged: (val) =>
                  {ref.read(userProvider.notifier).updateName(val)},
            ),
            InputEmail(
              name: "enter email",
              label: "Email",
              onchanged: (val) =>
                  {ref.read(userProvider.notifier).updateEmail(val)},
            )
          ],
        ));
  }
}
