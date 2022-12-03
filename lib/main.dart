import 'package:flutter/material.dart';
import 'package:gallery/screens/splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Camera',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenSplash(),
    );
  }
}
