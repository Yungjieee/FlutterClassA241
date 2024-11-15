import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_member_link/models/news.dart';
import 'package:my_member_link/myconfig.dart';
import 'package:my_member_link/views/edit_news.dart';
import 'package:my_member_link/views/new_news.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<News> newsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Newsletter"),
      ),
      body: newsList.isEmpty
          ? const Center(
              child: Text("Loading..."),
            )
          : ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color.fromARGB(255, 215, 237, 255),
                  child: ListTile(
                    onLongPress: () {
                      deleteDialog(index);
                    },
                    title: Text(truncateString(
                        newsList[index].newsTitle.toString(), 30)),
                    subtitle: Text(
                      truncateString(
                          newsList[index].newsDetails.toString(), 120),
                      textAlign: TextAlign.justify,
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          showNewsDetailsDialog(index);
                        },
                        icon: const Icon(Icons.arrow_forward_ios)),
                  ),
                );
              },
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
        backgroundColor: const Color.fromARGB(255, 174, 217, 255),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewNewsScreen()),
          );
          loadNewsData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void loadNewsData() {
    http
        .get(Uri.parse("${Myconfig.servername}/memberlink/api/load_news.php"))
        .then((response) {
      //log(response.body.toString());
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == "success") {
          var result = data['data']['news'];
          newsList.clear();
          for (var i in result) {
            News news = News.fromJson(i);
            newsList.add(news);
            //print(news.newsTitle);
          }
          setState(() {});
        }
      } else {
        print("Error");
      }
    });
  }

  String truncateString(String str, int length) {
    if (str.length > length) {
      str = str.substring(0, length);
      return "$str...";
    } else {
      return str;
    }
  }

  void showNewsDetailsDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 215, 237, 255),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            title: Text(newsList[index].newsTitle.toString()),
            content: Text(
              newsList[index].newsDetails.toString(),
              textAlign: TextAlign.justify,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    News news = newsList[index];
                    // print(news.newsTitle.toString());  //to check whether the news object can be passed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditNewsScreen(news: news)),
                    );
                  },
                  child: const Text("Edit")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"))
            ],
          );
        });
  }

  void deleteDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Delete \"${truncateString(newsList[index].newsTitle.toString(), 15)}\" ?",
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            content: const Text("Are you sure you want to delete this news?"),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteNews(index);
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("No")),
            ],
          );
        });
  }

  void deleteNews(int index) {
    String newsId = newsList[index].newsId.toString();
    http.post(
        //databse modification deals with post
        Uri.parse("${Myconfig.servername}/memberlink/api/delete_news.php"),
        body: {"newsId": newsId}).then((response) {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        log(data.toString());
        if (data['status'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Delete Success"),
            backgroundColor: Colors.green,
          ));
          loadNewsData(); //reload data after deletion
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Delete Failed"),
            backgroundColor: Colors.red,
          ));
        }
      }
    });
  }
}
