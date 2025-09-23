import 'package:flutter/material.dart';

class EmptyFavouriteList extends StatelessWidget {
  const EmptyFavouriteList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/image/empty-favorite.png"),
          SizedBox(height: 20),
          Text(
            'There are no products in',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          //
          Text(
            'your favourite list',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
