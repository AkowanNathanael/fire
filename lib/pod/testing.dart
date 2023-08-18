

class Human {
  String? name;
  String? age;
  String? gender;
  List<Map<String, dynamic>> friends = [
    {"name": "Nath", "isfav": true}
  ];
  Human({required this.name, required this.age, required this.gender});
}

Human h = Human(name: "nat", age: "23", gender: "male");

void main() {
  print(h.friends[0]["isfav"]);
}
