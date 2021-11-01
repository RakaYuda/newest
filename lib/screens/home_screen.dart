import 'package:flutter/material.dart';
import 'package:newest/components/card.dart';
import 'package:newest/models/news.dart';
import 'package:newest/provider/news_provider.dart';
import 'package:newest/style/style.dart';
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
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
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
      return Row(
        children: newsWidget,
      );
    }
  }

  Widget headlineNews(News news) {
    return Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              child: Image.network(news.urlToImage),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Logo"),
                  Column(
                    children: [
                      Text("Who was founder of microsoft company?"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            color: Colors.white,
                            child: Text("Tech"),
                          ),
                          Text("Read More"),
                        ],
                      )
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xFF121212),
                    ]),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<News> listNews = Provider.of<NewsProvider>(context).getListNews;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: headlineNews(listNews[0]),
      ),
    );
  }
}
