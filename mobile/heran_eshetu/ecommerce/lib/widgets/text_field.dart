import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  final String lable;
  final dynamic suffIcon;
  final int lines;
  final TextEditingController controller;
  const MyTextField({
    super.key,
    required this.lable,
    required this.lines,
    this.suffIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lable,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          maxLines: lines,
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffIcon,
            filled: true,
            fillColor: const  Color.fromARGB(155, 232, 229, 229),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
