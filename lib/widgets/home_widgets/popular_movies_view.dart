import 'package:flutter/material.dart';
import 'package:flutter_web_app/responsive.dart';
import 'package:go_router/go_router.dart';
import '../../models/movie_model.dart';

class MovieGridView extends StatefulWidget {
  final List<Movie> movies;

  const MovieGridView({super.key, required this.movies});

  @override
  State<MovieGridView> createState() => _MovieGridViewState();
}

class _MovieGridViewState extends State<MovieGridView> {
  int? hoverIndex;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: const Responsive().isMobile(context)
            ? 2
            : const Responsive().isTablet(context)
            ? 3
            : 5,
        childAspectRatio: const Responsive().isMobile(context) ? 0.7 : 0.8,
      ),
      itemBuilder: (context, index) {
        final movie = widget.movies[index];
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              hoverIndex = index;
            });
          },
          onExit: (_) {
            setState(() {
              hoverIndex = null;
            });
          },
          onHover: (_) {
            setState(() {
              hoverIndex = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: hoverIndex == index
                ? (Matrix4.identity()
              ..scale(1.05, 1.05)
              ..translate(0, -10))
                : Matrix4.identity(),
            child: GestureDetector(
              onTap: () {
                context.go('/movie/${movie.id}');
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Card(
                  elevation: hoverIndex == index ? 20 : 4,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListView(
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 226, 39, 22),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  const SizedBox(width: 5),
                                  Text(movie.voteAverage.toString())
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Language: ${movie.originalLanguage}',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('Adult: ${movie.adult ? 'Yes' : 'No'}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
