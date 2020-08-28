import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';

class MovieDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0),
                _posterTitle(context, movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie),
                _movieDescription(movie)
              ]
            )
          )
        ],
      )
    );
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.deepPurpleAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackdropImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 200),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow,),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1)
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
  

  Widget _movieDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}