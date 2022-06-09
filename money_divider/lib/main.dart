import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// widgets
import './widgets/get_amount.dart'; // main widget
import 'widgets/gradient_appbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  );
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