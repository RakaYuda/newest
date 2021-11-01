import 'package:flutter/material.dart';
import 'package:newest/models/news.dart';
import 'package:newest/style/style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebviewScreen extends StatelessWidget {
  static const id = 'news-webview-screen';

  final News news;
  NewsWebviewScreen({required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        titleTextStyle: TextStyle(
          color: kPrimaryColor,
          fontFamily: 'Charter',
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: kPrimaryColor, //change your color here
        ),
      ),
      body: WebView(
        initialUrl: news.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
