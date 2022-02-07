import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practica_final_2/models/models.dart';
import 'package:http/http.dart' as http;


class SimilarSlider extends StatefulWidget {
  final movieid;

  const SimilarSlider({Key? key, this.movieid}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SimilarSlider();
}

class _SimilarSlider extends State<SimilarSlider> {
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '73a4ef0a0780c2cf77b4930ec1d3725c';
  String _language = 'es-ES';
  String _page = '1';
  bool similarLoaded = false;

  List<Movie> similarMovies = [];

  Future<List<Movie>> fetchSimilarMovies(int movieid) async {
    var url = Uri.https(_baseUrl, '3/movie/${movieid}/similar', 
      {'api_key': _apiKey, 'language': _language, 'page': _page});

    final result = await http.get(url);

    final similarResponse = SimilarResponse.fromJson(result.body);

    similarMovies = similarResponse.results;

    setState(() {
      similarLoaded = true;
    });

    return similarResponse.results;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSimilarMovies(widget.movieid);
  }

  @override
  Widget build(BuildContext context) {
    return similarLoaded ?
    Container(
      width: double.infinity,
      height: 260,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text('Similar Movies', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 5,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: similarMovies.length,
              itemBuilder: (_, int index) => _MoviePoster(movie: similarMovies[index])
            ),
          )
        ],
      ),
    ) : Center(child: CircularProgressIndicator());
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({Key? key,required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterPath),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}