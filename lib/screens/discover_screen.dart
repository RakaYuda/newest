import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class DiscoverScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: darkBlue,
//       ),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Discover",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "News around the world",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 48,
                color: Colors.black,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: const Text(
                    "Search",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                listTileNews(),
                listTileNews(),
                listTileNews(),
                listTileNews(),
                listTileNews(),
                listTileNews(),
                listTileNews(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget listTileNews() {
  return Column(
    children: [
      Row(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16, right: 24),
              height: 72,
              width: 72,
              color: Colors.black),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text("Who was founder of microsoft company?",
                    style: TextStyle(fontSize: 18, color: Colors.black)),
                SizedBox(
                  height: 12,
                ),
                Text("1 hours ago",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ])
        ],
      ),
      Container(height: 1, color: Colors.black)
    ],
  );
}
