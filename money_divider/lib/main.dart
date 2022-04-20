import 'package:flutter/material.dart';

import './widgets/get_amount.dart'; // main widget

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
      appBar: AppBar(title: const Text('Money Divider'),),
      body: GetAmount(),
    );
  }
}