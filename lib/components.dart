import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  final double? width;
  final double? height;
  final String? name;
  final String? label;
  TextEditingController? c = TextEditingController();
  final Function(String)? onchanged;
  InputText(
      {Key? key,
      required this.name,
      required this.label,
      required this.onchanged,
      this.width,
      this.c,
      this.height})
      : super(key: key);

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  // dynamic name = widget.name;
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.red, width: 1, style: BorderStyle.solid)),
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.all(7),
      child: TextField(
        controller: widget.c,
        onSubmitted: widget.onchanged,
        maxLines: 2,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: widget.name, label: Text(widget.label.toString())),
      ),
    );
  }
}

class InputEmail extends StatefulWidget {
  final String? name;
  final String? label;
  final Function(String)? onchanged;
  const InputEmail({super.key, required this.name, this.label, this.onchanged})
      : super();

  @override
  State<InputEmail> createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      padding: const EdgeInsets.all(7),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.red, width: 1, style: BorderStyle.solid)),
      child: TextField(
        onChanged: widget.onchanged,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: widget.name, label: Text(widget.label.toString())),
      ),
    );
  }
}
