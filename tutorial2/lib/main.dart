import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  void _onScroll() {}

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    )..addListener(_onScroll);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          makePage(image: 'assets/images/maltesewp1.jpg'),
          makePage(image: 'assets/images/maltesewp2.jpg'),
          makePage(image: 'assets/images/maltesewp3.jpg'),
          makePage(image: 'assets/images/maltesewp4.jpg'),
        ],
      ),
    );
  }

  Widget makePage({image}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight, 
              stops: [0.3,0.9], 
              colors: [
                Colors.black.withOpacity(.9),
                Colors.black.withOpacity(.2),
              ]
           )
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('1', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold,),),
                  Text('/4', style: TextStyle(color: Colors.white, fontSize: 15, ),),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Maltese Day', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold,),),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child:Icon(Icons.star, color: Colors.yellow, size: 15,) ,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          ),
      ),
    );
  }
}
