import 'package:flutter/material.dart';
import 'package:my_member_link/views/events/new_event.dart';
import 'package:my_member_link/views/shared/my_drawer.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Events"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
        )],
      ),
      body: const Center(
        child: Text("Events Page"),
      ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(197, 60, 118, 255),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewEventScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}