import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class SearchMovies extends SearchDelegate<String> {

  //Build para borrar todo lo que haya escrito el usuario
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

  //Build para cerrar el search 
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      }, 
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation
        )
      );
  }

  //Build para los resultados
  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return FutureBuilder(
      future: moviesProvider.getSearchMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot ) {
        final List<Movie> search = moviesProvider.searchMovies;

        return ListView.builder(
            itemCount: search.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(search[index].title),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(search[index].fullPosterPath),
              ),
              onTap: () => Navigator.pushNamed(context, 'details', arguments: search[index]),
            ),
        );
      },
    );
  }

  //Build para sugerencias
  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    
    return FutureBuilder(
      future: moviesProvider.getSearchMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot ) {
        final List<Movie> search = moviesProvider.searchMovies;

        return ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(search[index].title),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(search[index].fullPosterPath),
              ),
              onTap: () => Navigator.pushNamed(context, 'details', arguments: search[index]),
            ),
        );
      },
    );
  }

}