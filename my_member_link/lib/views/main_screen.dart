import 'package:flutter/material.dart';
import 'package:my_member_link/views/new_news.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("MAIN SCREEN"),
      ),
      drawer: Drawer(
        child: ListView(children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            onTap: () {},
            title: const Text("Newsletter"),
          ),
          const ListTile(
            title: Text("Events"),
          ),
          const ListTile(
            title: Text("Members"),
          ),
          const ListTile(
            title: Text("Vetting"),
          ),
          const ListTile(
            title: Text("Payment"),
          ),
          const ListTile(
            title: Text("Product"),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewNewsScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
