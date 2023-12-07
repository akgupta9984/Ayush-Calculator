import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ayush Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AyushCalculator(),
    );
  }
}

class AyushCalculator extends StatefulWidget {
  const AyushCalculator({super.key});

  @override
  State<AyushCalculator> createState() => _AyushCalculatorState();
}

class _AyushCalculatorState extends State<AyushCalculator> {
  var userInput = '';
  var answer = '';

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      answer,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = '';
                            answer = '0';
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 1) {
                      // This is the index for '+/-' button
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            // Toggle the sign of the current input
                            userInput = userInput.startsWith('-')
                                ? userInput.substring(1)
                                : '-' + userInput;
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 2) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 3) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Color.fromARGB(255, 187, 210, 226),
                        textColor: Colors.black,
                      );
                    } else if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red[200],
                        textColor: Colors.white,
                      );
                    } else if (index == 19) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.red[200],
                        textColor: Colors.white,
                      );
                    } else {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userInput = userInput + buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.red[200]
                            : Colors.white,
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.black,
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finaluserinput = userInput;
    finaluserinput = userInput.replaceAll('%', '/100*');
    finaluserinput = userInput.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    answer = eval.toString();
    if (answer.endsWith(".0")) {
      answer = answer.substring(0, answer.length - 2);
    }
  }
}

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  MyButton(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GestureDetector(
        onTap: buttontapped,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: color,
              child: Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
