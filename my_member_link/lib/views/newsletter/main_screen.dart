import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_member_link/models/news.dart';
import 'package:my_member_link/myconfig.dart';
import 'package:my_member_link/views/newsletter/edit_news.dart';
import 'package:my_member_link/views/shared/my_drawer.dart';
import 'package:my_member_link/views/newsletter/new_news.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<News> newsList = [];
  final df = DateFormat('dd/MM/yyyy hh:mm a');
  int numofpage = 1;
  int curpage = 1;
  int numofresult = 0;
  late double screenwidth, screenHeight;
  var color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNewsData();
  }

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Newsletter"),
        actions: [
          IconButton(
            onPressed: () {
              loadNewsData();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: newsList.isEmpty
          ? const Center(
              child: Text("Loading..."),
            )
          : Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text("Page: $curpage/ Result: $numofresult"),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color.fromARGB(255, 215, 237, 255),
                        child: ListTile(
                          onLongPress: () {
                            deleteDialog(index);
                          },
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                truncateString(
                                    newsList[index].newsTitle.toString(), 30),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                df.format(DateTime.parse(
                                    newsList[index].newsDate.toString())),
                              ),
                            ],
                          ),
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
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: numofpage,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      //build the list for textbutton with scroll
                      if ((curpage - 1) == index) {
                        //set current page number active
                        color = Colors.red;
                      } else {
                        color = Colors.black;
                      }
                      return TextButton(
                          onPressed: () {
                            curpage = index + 1;
                            loadNewsData();
                          },
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: color, fontSize: 18),
                          ));
                    },
                  ),
                ),
              ],
            ),
      drawer: const MyDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(197, 60, 118, 255),
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
        .get(Uri.parse(
            "${Myconfig.servername}/memberlink/api/load_news.php?pageno=$curpage"))
        .then((response) {
      // log(response.body.toString());
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
          numofpage = int.parse(data['numofpage'].toString());
          numofresult = int.parse(data['numberofresult'].toString());
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
                  onPressed: () async {
                    Navigator.pop(context);
                    News news = newsList[index];
                    // print(news.newsTitle.toString());  //to check whether the news object can be passed
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditNewsScreen(news: news)),
                    );
                    loadNewsData();
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
