import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/widget/roundButton.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _prev = "0";
  String _current = "0";
  int _operator = 0; //0->none, 1->%, 2->/, 3->x, 4-> -, 5-> +
  bool _newNum = false;

  void _setCurrent(String entry) {
    setState(() {
      _current = entry;
    });
  }

  String _formatted(double num) {
    if (num.toInt() == num) return num.toInt().toString();
    return num.toString();
  }

  void _equalPressed() {
    if (!_newNum && _operator != 0) {
      _newNum = true;
      if (_operator == 1) {
        _setCurrent(
            _formatted(double.parse(_prev) * (double.parse(_current) / 100)));
      } else if (_operator == 2) {
        _setCurrent(_formatted(double.parse(_prev) / double.parse(_current)));
      } else if (_operator == 3) {
        _setCurrent(_formatted(double.parse(_prev) * double.parse(_current)));
      } else if (_operator == 4) {
        _setCurrent(_formatted(double.parse(_current) - double.parse(_prev)));
      } else if (_operator == 5) {
        _setCurrent(_formatted(double.parse(_prev) + double.parse(_current)));
      }
      _operator = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SizedBox(
                  height: screenHeight * 0.40,
                  width: screenWidth,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AutoSizeText(
                          _current,
                          textAlign: TextAlign.right,
                          maxFontSize: 60,
                          minFontSize: 20,
                          maxLines: 1,
                          stepGranularity: 1,
                          style: const TextStyle(
                              fontSize: 80,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 0.58 * screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RoundButton(
                          onPressed: () {
                            _setCurrent("0");
                            _prev = "0";
                            _operator =
                                0; //0->none, 1->%, 2->/, 3->x, 4-> -, 5-> +
                            _newNum = false;
                          },
                          text: "AC",
                          backgroundColor: const Color(0xFF8C8C8C),
                          textColor: Colors.black,
                        ),
                        RoundButton(
                          onPressed: () {
                            if (_current != "0") {
                              double temp = double.parse(_current);
                              temp = -1 * temp;
                              _setCurrent(_formatted(temp));
                            }
                            ;
                          },
                          text: "+/-",
                          backgroundColor: const Color(0xFF8C8C8C),
                          textColor: Colors.black,
                        ),
                        RoundButton(
                          onPressed: () {
                            _operator = 1;
                            _prev = _current;
                            _newNum = true;
                          },
                          text: "%",
                          backgroundColor: const Color(0xFF8C8C8C),
                          textColor: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RoundButton(
                            onPressed: () {
                              _operator = 2;
                              _prev = _current;
                              _newNum = true;
                            },
                            text: "÷",
                            backgroundColor: const Color(0xFFFFA00A),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RoundButton(
                              onPressed: () {
                                if (_newNum || _current == "0") {
                                  _setCurrent("7");
                                  _newNum = false;
                                } else {
                                  _setCurrent("${_current}7");
                                }
                              },
                              text: "7",
                            )),
                        RoundButton(
                          onPressed: () {
                            if (_newNum || _current == "0") {
                              _setCurrent("8");
                              _newNum = false;
                            } else {
                              _setCurrent("${_current}8");
                            }
                          },
                          text: "8",
                        ),
                        RoundButton(
                          onPressed: () {
                            if (_newNum || _current == "0") {
                              _setCurrent("9");
                              _newNum = false;
                            } else {
                              _setCurrent("${_current}9");
                            }
                          },
                          text: "9",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RoundButton(
                            onPressed: () {
                              _operator = 3;
                              _prev = _current;
                              _newNum = true;
                            },
                            text: "×",
                            backgroundColor: const Color(0xFFFFA00A),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RoundButton(
                              onPressed: () {
                                if (_newNum || _current == "0") {
                                  _setCurrent("4");
                                  _newNum = false;
                                } else {
                                  _setCurrent("${_current}4");
                                }
                              },
                              text: "4",
                            )),
                        RoundButton(
                          onPressed: () {
                            if (_newNum || _current == "0") {
                              _setCurrent("5");
                              _newNum = false;
                            } else {
                              _setCurrent("${_current}5");
                            }
                          },
                          text: "5",
                        ),
                        RoundButton(
                          onPressed: () {
                            if (_newNum || _current == "0") {
                              _setCurrent("6");
                              _newNum = false;
                            } else {
                              _setCurrent("${_current}6");
                            }
                          },
                          text: "6",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RoundButton(
                            onPressed: () {
                              _operator = 4;
                              _prev = _current;
                              _newNum = true;
                            },
                            text: "-",
                            backgroundColor: const Color(0xFFFFA00A),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RoundButton(
                              onPressed: () {
                                if (_newNum || _current == "0") {
                                  _setCurrent("1");
                                  _newNum = false;
                                } else {
                                  _setCurrent("${_current}1");
                                }
                              },
                              text: "1",
                            )),
                        RoundButton(
                          onPressed: () {
                            if (_newNum || _current == "0") {
                              _setCurrent("2");
                              _newNum = false;
                            } else {
                              _setCurrent("${_current}2");
                            }
                          },
                          text: "2",
                        ),
                        RoundButton(
                          onPressed: () {
                            if (_newNum || _current == "0") {
                              _setCurrent("3");
                              _newNum = false;
                            } else {
                              _setCurrent("${_current}3");
                            }
                          },
                          text: "3",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RoundButton(
                            onPressed: () {
                              _operator = 5;
                              _prev = _current;
                              _newNum = true;
                            },
                            text: "+",
                            backgroundColor: const Color(0xFFFFA00A),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: RoundButton(
                              onPressed: () {
                                if (_newNum || _current == "0") {
                                  _setCurrent("0");
                                  _newNum = false;
                                } else {
                                  _setCurrent("${_current}0");
                                }
                              },
                              text: "  0",
                              elongated: true,
                            )),
                        RoundButton(
                          onPressed: () {
                            if (!_current.contains('.'))
                              _setCurrent("$_current.");
                          },
                          text: ".",
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RoundButton(
                            onPressed: _equalPressed,
                            text: "=",
                            backgroundColor: const Color(0xFFFFA00A),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
