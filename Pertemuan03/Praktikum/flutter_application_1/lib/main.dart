import 'package:flutter/material.dart';
import 'package:flutter_application_1/material_app.dart';
// import 'package:flutter_application_1/statefull.dart';
// import 'package:flutter_application_1/stateless.dart';


void main() {
  runApp(const AppMaterial());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello, World! MAIN APP'),
        ),
      ),
    );
  }
}
