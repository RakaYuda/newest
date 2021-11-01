import 'package:flutter/material.dart';
import 'package:newest/models/news.dart';
import 'package:newest/provider/news_provider.dart';
import 'package:newest/screens/discover_screen.dart';
import 'package:newest/screens/news_webview_screen.dart';
import 'package:newest/style/style.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsScreen extends StatefulWidget {
  static const id = 'news-screen';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    Provider.of<NewsProvider>(context, listen: false).fetchNews();
    super.initState();
  }

  Widget loadingScreen() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      ),
    );
  }

  String getTimeAgoFormat(String date) {
    final DateTime dateString = DateTime.parse(date);

    return timeago.format(dateString);
  }

  List<Widget> getNewsWidget(List<News> listNews) {
    List<Widget> listWidgetNews = [];
    if (listNews.isNotEmpty) {
      listNews.forEach((news) {
        listWidgetNews.add(InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsWebviewScreen(
                  news: news,
                ),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(news.urlToImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    news.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textPrimary,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        getTimeAgoFormat(news.publishedAt),
                        style: textSecondary.copyWith(fontSize: 12),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'By ${news.author}',
                        style: textPrimary.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
        if (news != listNews.last) {
          listWidgetNews.add(Container(
            width: 1,
            color: Colors.black,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ));
        }
      });
    }
    return listWidgetNews;
  }

  @override
  Widget build(BuildContext context) {
    List<News> listNews = Provider.of<NewsProvider>(context).getListNews;

    return MaterialApp(
      title: 'Flutter Gradient Demo',
      home: Scaffold(
          backgroundColor: Colors.white,
          body: (listNews.isNotEmpty)
              ? Column(
                  children: [
                    Flexible(
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(listNews[0].urlToImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent,
                                  Color(0xFF121212)
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22, vertical: 32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/logo.png",
                                  height: 64,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      listNews[0].title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: textHeadingWhite.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          color: Colors.white,
                                          child: Text(
                                            'Tech',
                                            style: textPrimary.copyWith(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    NewsWebviewScreen(
                                                  news: listNews[0],
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Read More'),
                                          style: TextButton.styleFrom(
                                              primary: kWhiteColor,
                                              textStyle: textPrimaryWhite),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 22, right: 22, top: 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Popular News',
                                    style: textHeadingPrimary,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          (context), DiscoverScreen.id);
                                    },
                                    child: const Text('More'),
                                    style: TextButton.styleFrom(
                                      primary: kPrimaryColor,
                                      textStyle: textPrimary,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 18,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.1),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(
                                      left: 22, right: 22),
                                  children: getNewsWidget(listNews),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : loadingScreen()),
    );
  }
}
