import 'package:dio/dio.dart';
import 'package:newest/models/news.dart';

class ApiNewsProvider {
  final Dio _dio = Dio();
  final String _baseUrl = "https://newsapi.org";

  //Enter your api key here
  final String _apiNewsKey = "94a764d3b92a4c728deb8f579ec1164d";

  Future<List<News>> getNews() async {
    final Response response = await _dio
        .get('$_baseUrl/v2/everything?domains=wsj.com&apiKey=$_apiNewsKey');
    if (response.statusCode == 200) {
      List<News> news;

      news = (response.data['articles'] as List)
          .map((i) => News.fromJson(i))
          .toList();

      return news;
    } else {
      throw Exception('Failed to load List of news');
    }
  }
}
