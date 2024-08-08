import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color.fromARGB(255, 17, 17, 183),
        ),
      ),
      title: Text('Add Product'),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
