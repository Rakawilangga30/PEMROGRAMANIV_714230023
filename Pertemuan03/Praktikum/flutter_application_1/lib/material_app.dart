import 'package:flutter/material.dart';
import 'package:flutter_application_1/material_page.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: false),
      home: HomePage(),
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        shape: BoxShape.circle,
      ),
      // color: Colors.blue,
      // width: 200,
      // height: 100,
      // padding: EdgeInsets.only(top: 20, left: 20),
      margin: EdgeInsets.all(20),
      child: Text('Ini fesnuk', style: TextStyle(fontSize: 40)),
    );
  }
}

class MySizebox extends StatelessWidget {
  const MySizebox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
    );
  }
}

class MyPadding extends StatelessWidget {
  const MyPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('MainAxisAlignment.spaceEvenly'),
        MyRow(),
        MySizebox(),
        Text('MainAxisAlignment.spaceAround'),
        MyRow2(),
        MySizebox(),
        Text('MainAxisAlignment.spaceBetween'),
        MyRow3(),
        MySizebox(),
        Text('MainAxisAlignment.start'),
        MyRow4(),
        MySizebox(),
        Text('MainAxisAlignment.center'),
        MyRow5(),
        MySizebox(),
        Text('MainAxisAlignment.end'),
        MyRow6(),
      ],
    );
  }
}

class MyRow extends StatelessWidget {
  const MyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.share),
        Icon(Icons.thumb_up),
        Icon(Icons.thumb_down),
      ],
    );
  }
}

class MyRow2 extends StatelessWidget {
  const MyRow2({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(Icons.share),
        Icon(Icons.thumb_up),
        Icon(Icons.thumb_down),
      ],
    );
  }
}

class MyRow3 extends StatelessWidget {
  const MyRow3({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.share),
        Icon(Icons.thumb_up),
        Icon(Icons.thumb_down),
      ],
    );
  }
}

class MyRow4 extends StatelessWidget {
  const MyRow4({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.share),
        Icon(Icons.thumb_up),
        Icon(Icons.thumb_down),
      ],
    );
  }
}

class MyRow5 extends StatelessWidget {
  const MyRow5({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.share),
        Icon(Icons.thumb_up),
        Icon(Icons.thumb_down),
      ],
    );
  }
}

class MyRow6 extends StatelessWidget {
  const MyRow6({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.share),
        Icon(Icons.thumb_up),
        Icon(Icons.thumb_down),
      ],
    );
  }
}
