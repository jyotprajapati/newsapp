import 'package:flutter/material.dart';
import 'package:newsapp/Model/news_model.dart';
import 'package:newsapp/Views/home/widgets/news_card.dart';

import '../../Controllers/localDB_controller.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List<News>? bookmarks;
  _fetchBookmarks() async {
    bookmarks = await LocalDbController().loadBookmarks();
    setState(() {});
  }

  @override
  void initState() {
    _fetchBookmarks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bookmarks == null
          ? Center(child: CircularProgressIndicator())
          : bookmarks!.isEmpty
              ? Center(child: Text("No Bookmarks"))
              : ListView.builder(
                  itemCount: bookmarks?.length ?? 0,
                  itemBuilder: ((context, index) => Stack(
                        children: [
                          NewsCard(
                            item: bookmarks![index],
                            index: index,
                            isBookmark: true,
                          ),
                          Positioned(
                            right: 10,
                            top: 5,
                            child: IconButton(
                              icon: Icon(
                                Icons.bookmark_remove,
                                size: 50,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                bookmarks!.removeAt(index);
                                LocalDbController().setBookmarks(bookmarks!);
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      )),
                ),
    );
  }
}
