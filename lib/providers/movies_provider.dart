import 'package:flutter/cupertino.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/credits_response.dart';
import 'package:practica_final_2/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '73a4ef0a0780c2cf77b4930ec1d3725c';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Movies Provider inicialitzat');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    print('getPopularMovies');
    var url = Uri.https(_baseUrl, '3/movie/popular', 
      {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final popularMoviesResponse = PopularMovies.fromJson(result.body);

    popularMovies = popularMoviesResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    print('Casting');
    var url = Uri.https(_baseUrl, '3/movie/${idMovie}/credits', 
      {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Cast>> searchMovies(String movie) async {
    print('Casting');
    var url = Uri.https(_baseUrl, '3/search/movie', 
      {'api_key': _apiKey, 'language': _language, 'query': movie, 'page':});

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[movie] = creditsResponse.cast;

    return creditsResponse.cast;
  }

}
