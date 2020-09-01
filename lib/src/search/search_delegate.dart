import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';
import 'package:movies/src/models/movie_model.dart';

class DataSearch extends SearchDelegate {

  final moviesProvider = new MoviesProvider();

  /*List movies = [
    'Ironman',
    'Superman',
    'Batman',
    'Wolverine',
    'Wonderwoman',
    'Spiderman',
    'Daredevil'
  ];

  List lastMovies = [
    'Spiderman',
    'Daredevil'
  ];*/

  @override
  List<Widget> buildActions(BuildContext context) {
    // AppBar action buttons
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        }
      )
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
    // Icon to the left of the AppBar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: () {
        FocusScope.of(context).unfocus();
        final timer = Future.delayed(Duration(milliseconds: 500), () {});
        timer.then((value) {
          close(context, null);
        });
      }
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    // Create the results that we are going to show
    return Container();
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
    // These are the suggestions that appears when an user writes on the AppBar search

    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {

          final movies = snapshot.data;

          return ListView(
            children:
              movies.map((movie) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    image: NetworkImage(movie.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(movie.title),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.star, color: Colors.yellow),
                      Text(movie.voteAverage.toString())
                    ],
                  ),
                  onTap: () {
                    close(context, null);
                    movie.uniqueId = '${movie.id}-search';
                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                );
              }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );




    /*final suggestionList = (query.isEmpty) ?
                            lastMovies :
                            movies.where((movie) => movie.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestionList[index]),
          onTap: (){},
        );
      }
    );*/
  }

}
