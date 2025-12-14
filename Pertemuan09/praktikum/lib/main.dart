import 'package:flutter/material.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of you\                                                                                         kr application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 9',
      theme: ThemeData(primarySwatch: Colors.teal, useMaterial3: false),
      home: const LoginScreen(),
    );
  }
}