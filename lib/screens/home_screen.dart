import 'package:flutter/material.dart';
import 'package:newest/components/card.dart';
import 'package:newest/models/news.dart';
import 'package:newest/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
    super.initState();
  }

  Widget listNewsWidget(List<News> listNews) {
    if (listNews.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            'Empty Data',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      List<Widget> newsWidget = [];
      listNews.forEach((news) {
        newsWidget.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LargeNewsCard(
              title: news.title,
              urlImage: news.urlToImage,
            ),
          ),
        );
      });
      return Column(
        children: newsWidget,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<News> listNews = Provider.of<NewsProvider>(context).getListNews;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: listNewsWidget(listNews),
      ),
    );
  }
}
