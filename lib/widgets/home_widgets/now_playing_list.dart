import 'package:flutter/material.dart';
import 'package:flutter_web_app/models/movie_model.dart';
import 'package:go_router/go_router.dart';

class NowPlayingList extends StatelessWidget {
  final List<Movie> nowPlayingMovies;

  const NowPlayingList({super.key, required this.nowPlayingMovies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return ListTile(
          onTap: () {
            context.go('/movie/${movie.id}');
          },
          leading: Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            movie.title,
            style: const TextStyle(
              color: Color.fromARGB(255, 226, 39, 22),
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          subtitle: Text(
            movie.overview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }
}
