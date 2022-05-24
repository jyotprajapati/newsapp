import 'dart:convert';

import 'package:newsapp/Model/news_model.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/utils/ApiConstants.dart';

class FeedController {
  int page = 0;
  int totalItems = 0;
  Future<List<News>> fetchFeed() async {
    Uri uri = Uri.https(ApiConstants.BASE_URL, '/v2/top-headlines', {
      'country': 'in',
      'apiKey': ApiConstants.API_KEY,
      'pageSize': '20',
      'page': page.toString(),
    });
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("===> ${json['articles']} ");
      totalItems = json['totalResults'];
      print((json["articles"] as List).isEmpty);
      if ((json["articles"] as List).isEmpty) {
        return [];
      }
      page++;

      return (json['articles'] as List)
          .map<News>((article) => News.fromJson(article))
          .toList();
    } else {
      throw Exception('Failed to load feed');
    }
  }
}
