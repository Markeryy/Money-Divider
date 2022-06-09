import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      title: Text(
        'Money Divider', // title text
        style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

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