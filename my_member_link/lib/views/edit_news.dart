import 'package:flutter/material.dart';
import 'package:my_member_link/models/news.dart';

class EditNewsScreen extends StatefulWidget {
  final News news;
  const EditNewsScreen({super.key, required this.news});

  @override
  State<EditNewsScreen> createState() => _EditNewsScreenState();
}

class _EditNewsScreenState extends State<EditNewsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  late double screenwidth, screenheight;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.news.newsTitle.toString();
    detailsController.text = widget.news.newsDetails.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Newsletter"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    hintText: "News Title"),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: screenheight * 0.7,
                child: TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      hintText: "News Details"),
                  maxLines: screenheight ~/ 35,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                  elevation: 10,
                  onPressed: () {
                    onUpdateNewsDialog();
                  },
                  minWidth: 400,
                  height: 50,
                  color: const Color.fromARGB(197, 60, 118, 255),
                  child: const Text(
                    "Update News",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }
  
  void onUpdateNewsDialog() {}
}
