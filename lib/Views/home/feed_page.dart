import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newsapp/Controllers/feed_controller.dart';
import 'package:newsapp/Controllers/localDB_controller.dart';
import 'package:newsapp/Model/news_model.dart';
import 'package:newsapp/Views/home/widgets/news_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  List<News>? bookmarks;

  List<News> feed = [];
  FeedController _feedController = FeedController();
  final PagingController<int, News> _pagingController =
      PagingController(firstPageKey: 0);

  _loadBookmarks() async {
    bookmarks = await LocalDbController().loadBookmarks();
  }

  _getNews(int pageKey) async {
    final newItems = await _feedController.fetchFeed();
    // feed.addAll(newNews);
    int totalItems = _feedController.totalItems;

    final nextPageKey = pageKey + newItems.length;

    if (newItems.isEmpty) {
      _pagingController.appendLastPage(newItems);
    } else {
      _pagingController.appendPage(newItems, nextPageKey);
    }
  }

  @override
  void initState() {
    _loadBookmarks();
    _pagingController.addPageRequestListener((pageKey) {
      _getNews(pageKey);
    });

    super.initState();
  }

  isBookmarked(News item) {
    return bookmarks
            ?.where((element) =>
                element.title == item.title &&
                (element.source?.name ?? '') == (item.source?.name ?? ''))
            .isNotEmpty ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedListView(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<News>(
            itemBuilder: (context, item, index) {
          return NewsCard(
            item: item,
            index: index,
            isBookmark: isBookmarked(item),
          );
        }),
      ),
    );
  }
}
