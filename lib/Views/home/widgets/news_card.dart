import 'package:flutter/material.dart';
import 'package:newsapp/Views/home/news_details_page.dart';

import '../../../Model/news_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard(
      {Key? key,
      required this.isBookmark,
      required this.item,
      required this.index})
      : super(key: key);
  final News item;
  final int index;
  final bool isBookmark;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NewsDetailsPage(
                    news: item,
                    index: index,
                    isBookmark: isBookmark,
                  )),
          // PageRouteBuilder(
          //   pageBuilder: (c, a1, a2) => NewsDetailsPage(
          //     news: item,
          //   ),
          //   transitionsBuilder: (c, anim, a2, child) =>
          //       FadeTransition(opacity: anim, child: child),
          //   transitionDuration: Duration(milliseconds: 1000),
          // ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Hero(
                tag: "image$index",
                child: Image.network(
                  item.urlToImage ?? "",
                  height: MediaQuery.of(context).size.width / 1.5,
                  width: MediaQuery.of(context).size.width,
                  errorBuilder: (context, error, stackTrace) {
                    return Container();
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                item.title ?? "",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
