import 'package:flutter/cupertino.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:practica_final_2/models/credits_response.dart';
import 'package:practica_final_2/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  
  //Atributos para poder acceder a la API más parámetros
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '73a4ef0a0780c2cf77b4930ec1d3725c';
  String _language = 'es-ES';
  String _page = '1';
  bool loaded = false;

  //Listas para almacenar la información de los distintos métodos
  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> searchMovies = [];
  List<Movie> topRatedMovies = [];
  List<Movie> upcomingMovies = [];
  //List<Movie> similarMovies = [];
  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print('Movies Provider inicialitzat');
    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getTopRatedMovies();
    this.getUpcomingMovies();
  }

  //Método para conseguir el JSON de las películas now_playing
  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  //Método para conseguir el JSON de las películas populares
  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular', 
      {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final popularMoviesResponse = PopularMovies.fromJson(result.body);

    popularMovies = popularMoviesResponse.results;

    notifyListeners();
  }

  // Método para conseguir el JSON del cast de cada película
  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/${idMovie}/credits', 
      {'api_key': _apiKey, 'language': _language});

    final result = await http.get(url);

    final creditsResponse = CreditsResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  // Método para conseguir el JSON de las peliculas similares a una, se ha comentado debido a que se ha puesto en el widget SimilarMovies
 /* Future<List<Movie>> getSimilarMovie(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/${idMovie}/similar', 
      {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final similarResponse = SimilarResponse.fromJson(result.body);

    similarMovies = similarResponse.results;

    loaded = true;

    return similarResponse.results;
  }*/

  //Método para conseguir el JSON de las peliculas al utilizar el SearchDelegate
  Future<List<Movie>> getSearchMovies(String movie) async {
    var url = Uri.https(_baseUrl, '3/search/movie', 
      {'api_key': _apiKey, 'language': _language, 'query': movie, 'page': _page});

    final result = await http.get(url);

    final searchResponse = SearchResponse.fromJson(result.body);

    searchMovies = searchResponse.results;

    return searchMovies;
  }

  //Método para conseguir el JSON de las películas mejor puntuadas
  getTopRatedMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/top_rated',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final topRatedResponse = TopRatedResponse.fromJson(result.body);

    topRatedMovies = topRatedResponse.results;

    notifyListeners();
  }

  //Método para conseguir el JSON de las películas que están por salir
  getUpcomingMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/upcoming',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final upcomingResponse = UpcomingResponse.fromJson(result.body);

    upcomingMovies = upcomingResponse.results;

    notifyListeners();
  }  

}
