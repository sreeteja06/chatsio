import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/widgets/category_selector.dart';
import 'package:flutter_chat_ui/widgets/favorite_contacts.dart';
import 'package:flutter_chat_ui/widgets/recent_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pageNumber = 0;

  PageController _pageController;
  ScrollController _scrollcontroller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageNumber);
    _scrollcontroller = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function changePageViewByClick = (int pageNumber) {
      _pageController.animateTo(
        pageNumber.toDouble(),
        duration: Duration(seconds: 1),
        curve: Curves.decelerate,
      );
      _pageController.animateToPage(pageNumber,
          duration: Duration(milliseconds: 600), curve: Curves.decelerate);
      setState(() {
        _pageNumber = pageNumber;
      });
    };

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(
            changePageCallback: changePageViewByClick,
            pageNumber: _pageNumber,
            scrollController: _scrollcontroller,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: PageView(
                onPageChanged: (int page) {
                  _scrollcontroller.animateTo(
                    (page * 60).toDouble(),
                    duration: Duration(seconds: 1),
                    curve: Curves.decelerate,
                  );
                  setState(() {
                    _pageNumber = page;
                  });
                },
                controller: _pageController,
                children: <Widget>[
                  RecentChats(),
                  FavoriteContacts(),
                  RecentChats(),
                  FavoriteContacts(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
