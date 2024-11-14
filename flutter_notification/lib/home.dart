import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Local Notifications"),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.notifications_outlined, ),
              label: Text("Simple Notifications"),
              )
        ],
      ),
    );
  }
}
