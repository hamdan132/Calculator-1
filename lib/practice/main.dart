import 'package:calculator/practice/hide.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    // const FigmaToCodeApp(),
    const Quiz(),
  );
}

class Quiz extends StatefulWidget {
  const Quiz({Key? key})
      : super(
          key: key,
        );

  @override
  _QuizState createState() => _QuizState();
}

Color startBg = Colors.primaries[Random().nextInt(Colors.primaries.length)];
Color endBg = Colors.primaries[Random().nextInt(Colors.primaries.length)];

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Calculator",
      theme: ThemeData(primaryColor: const Color.fromARGB(40, 37, 37, 37)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(255, 106, 106, 106).withOpacity(0.1),
          title: const Center(
              child: Text(
            'Calculator',
            style: TextStyle(fontSize: 30),
          )),
        ),
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  startBg.withOpacity(0.7),
                  endBg.withOpacity(0),
                ],
              ),
            ),
            child: const Main(),
          ),
        ),
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  bool isFull = false;
  late var num;
  List<String> history = [];
  late String textToDisplay = '';
  Parser p = Parser();

  allClear() {
    // Clear all values and history when the "AC" button is pressed
    setState(() {
      num = 0; // Reset num to 0
      textToDisplay = ''; // Clear the text display
      history.clear(); // Clear the history
    });
  }

  clear() {
    // Clear the current value when the "C" button is pressed
    setState(() {
      num = 0; // Reset num to 0
      textToDisplay = ''; // Clear the text display
    });
  }

  dot() {
    // Handle decimal point
    setState(() {
      if (!textToDisplay.contains('.')) {
        // Add a decimal point only if it doesn't already exist in the text
        textToDisplay += '.';
      }
    });
  }

  void btnOnClick(String btnVal) {
    if (textToDisplay == "0258" && btnVal == '=') {
      setState(() {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => hide()),
        );
      });
    } else if (btnVal == "✏") {
      // Remove the last character from the text display when the "<" button is pressed
      setState(() {
        if (textToDisplay.isNotEmpty) {
          textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
        }
      });
    } else if (btnVal == "+/-") {
      // Toggle the sign of the number when the "+/-" button is pressed
      setState(() {
        if (textToDisplay.isNotEmpty) {
          if (textToDisplay[0] != '-') {
            textToDisplay = '-' + textToDisplay; // Make it negative
          } else {
            textToDisplay = textToDisplay.substring(1); // Make it positive
          }
        }
      });
    } else if (btnVal == "Sin") {
      // Handle Sin button
      // You can replace this with the logic you want for Sin
      // For example, you can calculate the sine of the current value in textToDisplay
      double value = double.tryParse(textToDisplay) ?? 0.0;
      double result = sin(value);
      setState(() {
        String formattedResult = result.toStringAsFixed(2);
        textToDisplay = formattedResult;
      });
    } else if (btnVal == "Cos") {
      // Handle Cos button
      // Similar to Sin, you can calculate the cosine of the current value
      double value = double.tryParse(textToDisplay) ?? 0.0;
      double result = cos(value);
      setState(() {
        String formattedResult = result.toStringAsFixed(2);
        textToDisplay = formattedResult;
      });
    } else if (btnVal == "Tan") {
      // Handle Tan button
      // Similar to Sin and Cos, calculate the tangent of the current value
      double value = double.tryParse(textToDisplay) ?? 0.0;
      double result = tan(value);
      setState(() {
        String formattedResult = result.toStringAsFixed(2);
        textToDisplay = formattedResult;
      });
    } else if (btnVal == 'x²') {
      // Handle x² button
      // You can implement the logic to square the current value
      double value = double.tryParse(textToDisplay) ?? 0.0;
      double result = value * value;
      setState(() {
        String formattedResult = result.toStringAsFixed(0);
        textToDisplay = formattedResult;
      });
    } else {
      // Handle other button presses
      setState(() {
        if (btnVal == '=') {
          if (textToDisplay.isNotEmpty) {
            Expression exp = p.parse(textToDisplay);
            ContextModel cm = ContextModel();
            num = exp.evaluate(EvaluationType.REAL, cm).toDouble();
            history.add(textToDisplay.toString());
            textToDisplay = num.toStringAsFixed(5);

            if (textToDisplay.endsWith('.00000')) {
              textToDisplay = num.toStringAsFixed(0);
            }

            // Check if the next character in textToDisplay is a digit
            bool nextCharIsDigit = textToDisplay.endsWith(
                (textToDisplay == "+" ||
                        textToDisplay == "-" ||
                        textToDisplay == "/" ||
                        textToDisplay == "*")
                    .toString());
            print(nextCharIsDigit);
            if (nextCharIsDigit) {
              clear(); // Call the clear() function
            }
          }
        } else {
          // Add the operator to textToDisplay
          // Replace 'operator' with the actual operator you want to add
          textToDisplay += btnVal;
        }

        if (history.length >= 7 && isFull) {
          history.removeAt(
              0); // Remove the oldest history entry if it exceeds 8 entries
        }
        if (history.length >= 8 && !isFull) {
          history.removeAt(
              0); // Remove the oldest history entry if it exceeds 8 entries
        }
      });

      switch (btnVal) {
        case '❌':
          allClear();
          break;
        case "〰":
          clear();
          break;
        case '.':
          dot();
          break;

        // case 'Sin':
        //   Sin();
        //   break;
        // case 'Cos':
        //   Cos();
        //   break;
        // case 'Tan':
        //   Tan();
        //   break;
        // case 'x²':
        //   Sin();
        //   break;

        default:
      }
    }
  }

  double stextsize = 18;
  double mtextsize = 32;
  double ltextsize = 40;
  Color tcolor = const Color.fromARGB(255, 255, 255, 255);
  Color scolor = const Color.fromARGB(255, 255, 115, 0);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (var _history in history) ...[
          Container(
            margin: const EdgeInsets.only(right: 20),
            alignment: const Alignment(1.0, 1.0),
            child: Text(
              _history,
              style: const TextStyle(
                fontSize: 30,
                color: Color.fromARGB(199, 255, 255, 255),
              ),
            ),
          ),
        ],
        Container(
          margin: const EdgeInsets.only(right: 20),
          alignment: const Alignment(1.0, 1.0),
          child: Text(
            textToDisplay.toString(),
            style: const TextStyle(
              fontSize: 40,
              color: Color.fromARGB(199, 255, 255, 255),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            button(
              text: '❌',
              textsize: stextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '〰',
              textsize: mtextsize,
              color: scolor,
              callBack: btnOnClick,
            ),
            button(
              text: '✏',
              textsize: mtextsize,
              color: scolor,
              callBack: btnOnClick,
            ),
            button(
              text: '/',
              textsize: ltextsize,
              color: scolor,
              callBack: btnOnClick,
            ),
          ],
        ),
        isFull
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  button(
                    text: 'Sin',
                    textsize: stextsize,
                    color: scolor,
                    callBack: btnOnClick,
                  ),
                  button(
                    text: 'Cos',
                    textsize: stextsize,
                    color: scolor,
                    callBack: btnOnClick,
                  ),
                  button(
                    text: 'Tan',
                    textsize: stextsize,
                    color: scolor,
                    callBack: btnOnClick,
                  ),
                  button(
                    text: 'x²',
                    textsize: 22,
                    color: scolor,
                    callBack: btnOnClick,
                  ),
                ],
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            button(
              text: '7',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '8',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '9',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '*',
              textsize: ltextsize,
              color: scolor,
              callBack: btnOnClick,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            button(
              text: '4',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '5',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '6',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '-',
              textsize: ltextsize,
              color: scolor,
              callBack: btnOnClick,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            button(
              text: '1',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '2',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '3',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '+',
              textsize: mtextsize,
              color: scolor,
              callBack: btnOnClick,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              child: isFull
                  ? Row(
                      children: [
                        ToggleScreen(
                          Icons.close_fullscreen,
                        ),
                        button(
                          text: '+/-',
                          textsize: stextsize,
                          color: tcolor,
                          callBack: btnOnClick,
                        ),
                      ],
                    )
                  : ToggleScreen(
                      Icons.open_in_full,
                    ),
            ),
            button(
              text: '0',
              textsize: mtextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            button(
              text: '.',
              textsize: ltextsize,
              color: tcolor,
              callBack: btnOnClick,
            ),
            CircleAvatar(
              radius: ltextsize,
              backgroundColor: const Color.fromARGB(2, 255, 255, 255),
              child: button(
                text: '=',
                textsize: mtextsize,
                color: scolor,
                callBack: btnOnClick,
              ),
            )
          ],
        ),
      ],
    );
  }

  ToggleScreen(icon) {
    return Container(
      margin: const EdgeInsets.all(12),
      alignment: AlignmentDirectional.bottomStart,
      child: IconButton(
        icon: Icon(
          icon,
          size: stextsize,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            if (icon == Icons.close_fullscreen) {
              isFull = false;
            } else if (icon == Icons.open_in_full) {
              isFull = true;
            }
          });
        },
      ),
    );
  }
}

class button extends StatefulWidget {
  final String text;
  final Color color;
  final double textsize;
  final Function callBack;
  const button(
      {Key? key,
      required this.text,
      required this.textsize,
      required this.callBack,
      required this.color})
      : super(key: key);

  @override
  State<button> createState() => _buttonState();
}

class _buttonState extends State<button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: () {
          widget.callBack(widget.text);
        },
        child: Text(
          widget.text,
          style: GoogleFonts.rubik(
            fontSize: widget.textsize,
            color: widget.color,
            shadows: [
              const Shadow(
                blurRadius: 20.0, // shadow blur
                color: Color.fromARGB(84, 0, 0, 0), // shadow color
                offset: Offset(5, 5), // how much shadow will be shown
              ),
            ],
          ),
        ),
      ),
    );
  }
}
