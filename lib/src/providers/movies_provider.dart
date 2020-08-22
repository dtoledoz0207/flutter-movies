import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';

class MoviesProvider {

  String _apikey = '3f8ace2c02ff13704411f19cbfc2187d';
  String _url  = 'api.themoviedb.org';
  String _language = 'en-US';

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

}