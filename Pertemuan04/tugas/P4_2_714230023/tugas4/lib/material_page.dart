import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tugas Pertemuan 4',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: false, 
        iconTheme: const IconThemeData(color: Colors.white), 
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 60,
              color: Colors.blue,
              alignment: Alignment.center,
              child: const Text(
                'Box 1',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const Text(
                    'Box 2',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  width: 100,
                  height: 100,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: const Text(
                    'Box 3',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
