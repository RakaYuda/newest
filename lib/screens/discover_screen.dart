import 'package:flutter/material.dart';
import 'package:newest/models/news.dart';
import 'package:newest/provider/news_provider.dart';
import 'package:newest/screens/news_webview_screen.dart';
import 'package:newest/style/style.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class DiscoverScreen extends StatelessWidget {
  static const id = 'discover-screen';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: darkBlue,
//       ),
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(child: MyWidget()),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
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

  @override
  Widget build(BuildContext context) {
    List<News> listNews = Provider.of<NewsProvider>(context).getListNews;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Discover",
                style: textPrimary.copyWith(
                    fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "News around the world",
                style: textPrimary,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 48,
                color: Colors.black,
                child: TextButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: SearchNews(listNews));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                  ),
                  child: Text(
                    "Search",
                    style: textPrimaryWhite,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Flexible(
            child: (listNews.isEmpty)
                ? loadingScreen()
                : ListView(
                    scrollDirection: Axis.vertical,
                    children: listNews
                        .map((news) => listTileNews(context, news))
                        .toList()),
          )
        ],
      ),
    );
  }
}

String getTimeAgoFormat(String date) {
  final DateTime dateString = DateTime.parse(date);

  return timeago.format(dateString);
}

Widget listTileNews(BuildContext context, News news) {
  return Column(
    children: [
      InkWell(
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
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16, right: 24),
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(news.urlToImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Flexible(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(news.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textPrimary.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      getTimeAgoFormat(news.publishedAt),
                      style: textSecondary.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
      Container(height: 1, color: Colors.black)
    ],
  );
}

class SearchNews extends SearchDelegate {
  final List<News> listNews;
  List<News> recentList = [];
  News selectedItem = new News();

  SearchNews(this.listNews);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        color: Colors.white,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: kPrimaryColor,
          fontFamily: 'Charter',
        ),
      ),
      primaryColor: Colors.amber,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        hintStyle: TextStyle(fontFamily: 'Charter'),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
          size: 24,
          color: darkBlue,
        ),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        size: 24,
        color: darkBlue,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.only(left: 12, right: 12, top: 24),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Expanded(child: listTileNews(context, selectedItem)),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<News> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList
            .addAll(listNews.where((element) => element.title.contains(query)));
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 22),
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return listTileNews(context, listNews[index]);
        });
  }
}
