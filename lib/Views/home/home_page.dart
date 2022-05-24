import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Views/home/bookmarks_page.dart';

import 'feed_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> screens = [FeedPage(), BookmarksPage()];
  int _currentIindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey, ${FirebaseAuth.instance.currentUser?.displayName}"),
      ),
      body: screens[_currentIindex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _currentIindex = value;
          });
        },
        currentIndex: _currentIindex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: "feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Bookmarks",
          ),
        ],
      ),
    );
  }
}
