import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyShared extends StatefulWidget {
  const MyShared({super.key});
  @override
  State<MyShared> createState() {
    return _MySharedState();
  }
}

class _MySharedState extends State<MyShared> {
  late SharedPreferences prefs;
  final TextEditingController _dataAja = TextEditingController();
  final TextEditingController _displayController = TextEditingController();
  String name = "";

  @override
  void dispose() {
    _dataAja.dispose();
    _displayController.dispose();
    super.dispose();
  }

  save() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('IniData', _dataAja.text.toString());
    _dataAja.clear();
  }

  retrieve() async {
  prefs = await SharedPreferences.getInstance();
  final v = prefs.getString('IniData');
  setState(() {
    if (v == null || v.isEmpty) {
      _displayController.text = 'null';
    } else {
      _displayController.text = v;
    }
  });
}

  delete() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('IniData');
    setState(() {
      name = "";
      _displayController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Preferences")),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _dataAja,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                save();
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _displayController,
              readOnly: true,
              decoration: InputDecoration(border: const OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Get Value"),
              onPressed: () {
                retrieve();
              },
            ),
            ElevatedButton(child: const Text("Delete Value"), onPressed: () {
              delete();
            }),
          ],
        ),
      ),
    );
  }
}