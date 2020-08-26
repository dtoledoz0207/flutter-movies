import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {

  String _apikey = '3f8ace2c02ff13704411f19cbfc2187d';
  String _url  = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularPage = 0;

  List<Movie> _popularMovies = new List();
  final _popularMoviesStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularMoviesSink => _popularMoviesStreamController.sink.add;
  Stream<List<Movie>> get popularMoviesStream => _popularMoviesStreamController.stream;

  void disposeStreams() {
    _popularMoviesStreamController?.close();
  }


  Future<List<Movie>> getOnMovieTheater() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language
    });

    final response = await http.get(url);
    final decodedData = jsonDecode(response.body);

    final movies = Movies.fromJsonList(decodedData['results']);

    return movies.listMovies;
  }

  Future<List<Movie>> getPopularMovies() async {

    _popularPage++;

    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularPage.toString()
    });

    final response = await http.get(url);
    final decodedData = jsonDecode(response.body);

    final popularMovies = Movies.fromJsonList(decodedData['results']);

    _popularMovies.addAll(popularMovies.listMovies);
    popularMoviesSink(_popularMovies);

    return popularMovies.listMovies;
  }

}