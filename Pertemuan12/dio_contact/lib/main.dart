import 'package:dio_contact/view/screen/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner DEBUG miring
      title: 'Flutter Dio Contact',
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Warna dasar biru sesuai modul
        useMaterial3: false, // [PENTING] Matikan ini agar tombol terlihat kotak & solid
      ),
      home: const HomePage(),
    );
  }
}