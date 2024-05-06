

import '../models/NewsHeadlinesModel.dart';
import '../models/catgory_news_model.dart';
import '../repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsHeadlinesModel> fetchNewsChannelHeadLinesApi(String name) async {
    final response = await _rep.fetchNewsChannelHeadLinesApi(name);
    return response;
  }

  Future<category_news_model> fetchcategorynewsApi(String category) async {
    final response = await _rep.fetchcategorynewsApi(category);
    return response;
  }
}
