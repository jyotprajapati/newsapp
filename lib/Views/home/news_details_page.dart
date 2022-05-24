import 'package:flutter/material.dart';
import 'package:newsapp/Controllers/localDB_controller.dart';
import 'package:newsapp/Model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatefulWidget {
  NewsDetailsPage({
    Key? key,
    required this.news,
    required this.index,
    required this.isBookmark,
  }) : super(key: key);
  final News news;
  bool isBookmark;
  final int index;

  @override
  State<NewsDetailsPage> createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Hero(
                    tag: "image${widget.index}",
                    child: Image.network(
                      widget.news.urlToImage ?? "",
                      errorBuilder: (context, error, stackTrace) {
                        return Container();
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.news.title ?? "",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.news.description ?? "",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.news.content ?? "",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      widget.news.author ?? "",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      widget.news.source?.name ?? "",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          if (!widget.isBookmark)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Bookmark".toUpperCase(),
                            style: TextStyle(fontSize: 14)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.bookmark_border),
                      ],
                    ),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      LocalDbController().addToBookmarks(widget.news);
                      widget.isBookmark = true;
                      setState(() {});
                    }),
              ),
            ),
          if (widget.news.url != null)
            Container(
              color: Colors.grey[200],
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      try {
                        launchUrl(Uri.parse(widget.news.url!));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error opening link")));
                      }
                    },
                    child: Text(
                      "Read on ${widget.news.source?.name ?? 'publisher site'}",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            )
        ],
      ),
    );
  }
}
