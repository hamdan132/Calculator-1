import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

List<String> history = [];

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    // Remove duplicates by creating a set and adding items to it.
    Set<String> uniqueHistory = Set.from(history);

    // Convert the set to a list and reverse it to display newer values at the top.
    List<String> reversedHistory = uniqueHistory.toList();
    reversedHistory = List.from(reversedHistory.reversed);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Center(
          child: Text(
            "History",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: reversedHistory.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white, width: 2),
              ),
            ),
            child: SizedBox(
              height: 50,
              child: Center(
                child: Text(
                  reversedHistory
                      .elementAt(index), // Access elements from the set
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
