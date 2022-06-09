import 'package:flutter/material.dart';

// class for appbar widget (no search icon)
// app bar needs preferredsize
class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GradientAppBar({ Key? key }) : super(key: key);

  // preferredsize getter
  @override
  Size get preferredSize => const Size.fromHeight(60);

  // widget build method
  // takes in context
  // returns the widget
  @override
  Widget build(BuildContext context) {

    // APPBAR
    return AppBar(
      title: const Text('Money Divider'),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red, Colors.purple],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          )
        ),
      ),

    );
  }
}