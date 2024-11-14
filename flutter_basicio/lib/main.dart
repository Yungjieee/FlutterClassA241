
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController text1EditingController = TextEditingController();
  TextEditingController text2EditingController = TextEditingController();
  String name = "";
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Basic IO",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Basic IO"),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:Card(
                elevation: 20,
                shadowColor: Colors.red,
              
              child: Column(
                children: [
                  TextField(
                    controller: text1EditingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Enter First Number"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: text2EditingController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Enter First Number"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(height:8,thickness: 2, color: Colors.red,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: calculateMe,
                          child: const Text("Calculate")),
                      ElevatedButton(
                          onPressed: clearScreen, child: const Text("Clear")),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "OUTPUT: $result",
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            ),
          ),
        ));
  }

  calculateMe() {
    int num2 = int.parse(text2EditingController.text);
    int num1 = int.parse(text1EditingController.text);
    result = num1 + num2;
    setState(() {});
  }

  void clearScreen() {
    text1EditingController.text = "";
    text2EditingController.text = "";
    result = 0;
    setState(() {});
  }
}
