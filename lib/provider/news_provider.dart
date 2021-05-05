import 'package:flutter/material.dart';
import 'package:newest/api/repository/api_news_repository.dart';
import 'package:newest/models/news.dart';

class NewsProvider extends ChangeNotifier {
  List<News> _listNews = [];
  ApiNewsRepository _newsRepository = ApiNewsRepository();

  List<News> get getListNews {
    return _listNews;
  }

  void fetchNews() async {
    _listNews = await _newsRepository.fetchNews();
    notifyListeners();
  }
}
