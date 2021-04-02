import 'package:calculator_app/calculator_buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalCulatorScreen extends StatefulWidget {
  @override
  _CalCulatorScreenState createState() => _CalCulatorScreenState();
}

class _CalCulatorScreenState extends State<CalCulatorScreen> {
  var userData = '';
  var userAns = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '00',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Calculator',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 40.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      backgroundColor: Colors.pink[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text('Enter the Expression To Calculate:'),
                          Text(userData),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Text('Answer'),
                          Text(userAns),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                  child: GridView.builder(
                      itemCount: buttons.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return CalculatorButton(
                            buttonTapped: () {
                              setState(() {
                                userData = '';
                                userAns = '';
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: Colors.green[200],
                            textColor: Colors.white,
                          );
                        } else if (index == 1) {
                          return CalculatorButton(
                            buttonTapped: () {
                              setState(() {
                                userData =
                                    userData.substring(0, userData.length - 1);
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: Colors.orange,
                            textColor: Colors.white,
                          );
                          //equal nutton
                        } else if (index == buttons.length - 1) {
                          return CalculatorButton(
                            buttonTapped: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: Colors.orange,
                            textColor: Colors.white,
                          );
                        } else {
                          return CalculatorButton(
                            buttonTapped: () {
                              setState(() {
                                userData += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            buttonColor: isOperator(buttons[index])
                                ? Colors.pink
                                : Colors.white,
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.pink,
                          );
                        }
                      })),
              // color: Colors.pink,
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == 'X' || x == '+' || x == '-' || x == '=' || x == '/') {
      return true;
    } else
      return false;
  }

  void equalPressed() {
    String finalQue = userData;
    finalQue = finalQue.replaceAll('X', '*');
    // finalQue = finalQue.replaceAll('Your Question? ', '');
    Parser p = Parser();
    Expression exp = p.parse(finalQue);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    // userAns = userAns.replaceAll('Ans ', '');
    userAns = eval.toString();
  }
}
