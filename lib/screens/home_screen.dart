import 'package:flutter/material.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Cartellera'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchMovies(context: context));
              }, 
              icon: Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovies),

              // Slider de pel·licules
              MovieSlider(movies: moviesProvider.popularMovies, category: 'Populars',),
              Divider(),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
              MovieSlider(movies: moviesProvider.topRatedMovies, category: 'Top Rated',),
              Divider(),
              MovieSlider(movies: moviesProvider.upcomingMovies, category: 'Upcoming',),
            ],
          ),
        )));
  }
}
