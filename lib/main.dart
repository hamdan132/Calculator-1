import 'package:calculator/design.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Cal(),
  );
}

class Cal extends StatefulWidget {
  const Cal({Key? key}) : super(key: key);

  @override
  _CalState createState() => _CalState();
}

class _CalState extends State<Cal> {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Center(
            child: Text(
              'Calculator',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: const Design(),
      ),
    );
  }
}
