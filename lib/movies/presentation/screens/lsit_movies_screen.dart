import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/network/api_constants.dart';
import 'package:movie_app/movies/data/models/movie_model.dart';
import 'package:movie_app/movies/presentation/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class ListMoviesScreen extends StatelessWidget {
  const ListMoviesScreen({
    super.key,
    required this.title,
    required this.movies,
  });

  final String title;
  final List<MovieModel> movies;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text('$title Movies'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: movies.length,
        itemBuilder: (context, index) => _Card(movie: movies[index]),
        separatorBuilder: (_, __) => const SizedBox(height: 10),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailScreen(id: movie.id))),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: CachedNetworkImage(
                width: 120,
                height: 150,
                fit: BoxFit.cover,
                imageUrl: ApiConstants.imageUrl(movie.backdropPath),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 170.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(5)),
                          child: Text(movie.releaseDate.substring(0, 4)),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star_rate_rounded, color: Colors.amber),
                        Text(movie.voteAverage.toString()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(movie.overview, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // const Row(
    // children: [
    // ClipRRect(
    //   borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    //   child: CachedNetworkImage(
    //     width: 100,
    //     height: 140,
    //     fit: BoxFit.cover,
    //     imageUrl: ApiConstants.imageUrl(movie.backdropPath),
    //     placeholder: (context, url) => Shimmer.fromColors(
    //       baseColor: Colors.grey[850]!,
    //       highlightColor: Colors.grey[800]!,
    //       child: Container(
    //         height: 170.0,
    //         width: 120.0,
    //         decoration: BoxDecoration(
    //           color: Colors.black,
    //           borderRadius: BorderRadius.circular(8.0),
    //         ),
    //       ),
    //     ),
    //     errorWidget: (context, url, error) => const Icon(Icons.error),
    //   ),
    // ),
    //   ],
    // );
  }
}
