import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyTextField extends StatelessWidget {
  final String lable;
  final suff_icon;
  final int lines;
  MyTextField({
    super.key,
    required this.lable,
    required this.lines,
    this.suff_icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lable,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintMaxLines: lines,
              suffixIcon: suff_icon,
              filled: true,
              fillColor: Color.fromARGB(155, 232, 229, 229),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
