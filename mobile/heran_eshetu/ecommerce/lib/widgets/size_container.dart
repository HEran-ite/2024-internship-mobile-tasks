import 'package:flutter/material.dart';

class SizeContainer extends StatefulWidget {
  final int size;

  SizeContainer({super.key, required this.size});

  @override
  State<SizeContainer> createState() => _SizeContainerState();
}

class _SizeContainerState extends State<SizeContainer> {
  bool isSelected = false;

  void select() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: select,
      child: Container(
        margin: EdgeInsets.only(left: 30, bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? Color.fromARGB(255, 45, 69, 206)
              : const Color.fromARGB(255, 255, 252, 252),
        ),
        child: Text(
          widget.size.toString(),
          style: TextStyle(
              fontSize: 20, color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
