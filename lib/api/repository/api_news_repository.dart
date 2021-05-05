import 'package:newest/api/provider/api_news_provider.dart';
import 'package:newest/models/news.dart';

class ApiNewsRepository {
  final ApiNewsProvider _apiNewsProvider = ApiNewsProvider();

  Future<List<News>> fetchNews() => _apiNewsProvider.getNews();
}
