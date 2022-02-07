import 'package:flutter/material.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:practica_final_2/providers/movies_provider.dart';
import 'package:practica_final_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: Canviar després per una instància de Peli
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final movies = moviesProvider.getSimilarMovie(movie.id);
    final similarMovies = moviesProvider.similarMovies;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(movie: movie),
            SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitile(movie: movie),
                _Overview(movie: movie),
                CastingCards(idMovie: movie.id),
                MovieSlider(movies: similarMovies, category: 'Similar Movies')
              ])
            )
          ],
        )
    );
  }
}


class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16)
            ,
          ),
        ),

        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackDropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;

  const _PosterAndTitile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
            ),
          ),
          SizedBox(width: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 170
            ),
            child: Column(
              children: [
                Text(movie.title, style: textTheme.headline5, overflow: TextOverflow.clip, maxLines: 2, textAlign: TextAlign.center,),
                Text(movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.clip, maxLines: 2, textAlign: TextAlign.center),
                Row(
                  children: [
                    Icon(Icons.star_outline,size: 15, color: Colors.grey),
                    SizedBox(width: 5,),
                    Text('${movie.voteAverage}', style: textTheme.caption),
                  ],
                )
              ],
            ),
          )  
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;

  const _Overview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text( 
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}