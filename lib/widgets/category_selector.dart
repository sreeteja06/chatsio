import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final int pageNumber;
  final Function changePageCallback;
  final ScrollController scrollController;
  CategorySelector(
      {this.pageNumber, this.changePageCallback, this.scrollController});

  @override
  Widget build(BuildContext context) {

    final List<String> categories = ['Messages', 'Calls', 'Groups', 'Support'];
    return Container(
      height: 70.0,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: scrollController,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              changePageCallback(index);
              scrollController.animateTo(
                (index * 60).toDouble(),
                duration: Duration(seconds: 1),
                curve: Curves.decelerate,
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: index == pageNumber ? Colors.white : Colors.white60,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
