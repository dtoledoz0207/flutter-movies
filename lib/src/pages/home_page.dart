import 'package:flutter/material.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}
          )
        ],
        centerTitle: false,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperCards()
          ],
        ),
      )
    );
  }

  Widget _swiperCards() {
    return CardSwiper(
      movies: [1,2,3,4,5]
    );
  }
}