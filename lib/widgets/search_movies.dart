import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';

class SearchMovies extends SearchDelegate<String> {
  
  final List<Movie> popularMovies;
  final List<Movie> suggestionMovies;

  SearchMovies(this.popularMovies, this.suggestionMovies);
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        }, 
        icon: Icon(Icons.clear)
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {}, 
      icon: Icon(Icons.arrow_back)
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Movie> allMovies = popularMovies.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: allMovies.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allMovies[index].title),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Movie> suggestedMovies = suggestionMovies.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestedMovies.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestedMovies[index].title),
      ),
    );
  }

}