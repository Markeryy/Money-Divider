import 'package:flutter/material.dart';

// widgets
import './widgets/get_amount.dart'; // main widget
import 'widgets/gradient_appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Divider',
      home: const HomeScreen(),
      theme: ThemeData.dark(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(27, 22, 38, 1),
      appBar: const GradientAppBar(),
      body: GetAmount(),
    );
  }
}