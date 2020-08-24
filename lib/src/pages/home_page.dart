import 'package:flutter/material.dart';

import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

  final moviesProvider = new MoviesProvider();

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

    return FutureBuilder(
      future: moviesProvider.getOnMovieTheater(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return LinearProgressIndicator();
        }
        
      }
    );

    /*moviesProvider.getOnMovieTheater();
    return CardSwiper(
      movies: [1,2,3,4,5]
    );*/
  }
}