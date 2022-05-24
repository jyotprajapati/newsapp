import 'dart:convert';

import 'package:newsapp/Model/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDbController {
  addToBookmarks(News news) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = _prefs.getStringList('bookmarks') ?? [];
    bookmarks.add(jsonEncode(news.toJson()));
    _prefs.setStringList('bookmarks', bookmarks);
  }

  loadBookmarks() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = _prefs.getStringList('bookmarks') ?? [];
    return bookmarks.map((bookmark) {
      return News.fromJson(jsonDecode(bookmark));
    }).toList();
  }

  setBookmarks(List<News> bookmarks) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> bookmarksList = bookmarks.map((bookmark) {
      return jsonEncode(bookmark.toJson());
    }).toList();
    _prefs.setStringList('bookmarks', bookmarksList);
  }
}
