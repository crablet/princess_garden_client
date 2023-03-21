import 'package:flutter/material.dart';
import 'package:princess_garden_client/app_root_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Princess's Garden",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppRootContainer(),
    );
  }
}
