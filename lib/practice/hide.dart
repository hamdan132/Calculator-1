import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class hide extends StatefulWidget {
  const hide({Key? key}) : super(key: key);

  @override
  _hideState createState() => _hideState();
}
 String? makePassword;

class _hideState extends State<hide> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primaryColor: const Color.fromARGB(40, 37, 37, 37)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          title: const Center(
              child: Text(
            'Calculator',
            style: TextStyle(fontSize: 30),
          )),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              onLongPress: (){
                makePassword;
              },
              child: const Center(
                child: Text(
                  'You will know pretty soon...🤫',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Lottie.asset('assets/Animations/Animation - 1697625805539.json'),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
