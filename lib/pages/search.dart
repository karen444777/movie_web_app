import 'package:flutter/material.dart';
import 'package:flutter_web_app/main.dart';
import 'package:flutter_web_app/models/movie_model.dart';
import 'package:flutter_web_app/services/movie_services.dart';
import 'package:flutter_web_app/widgets/skeleton/footer.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  final String query;

  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Movie> movies = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    movies = await MovieServices().searchMovies(widget.query);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results for ${widget.query}'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: movies.length,
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 6,
                        child: InkWell(
                          onTap: () {
                            context.go('/movie/${movie.id}');
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                Image.network(
                                  'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                  width: 120,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 226, 39, 22),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        movie.overview,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 10),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Vote Count: ${movie.voteCount}',
                                            ),
                                            const SizedBox(width: 10),
                                            const Icon(
                                              Icons.trending_up,
                                              color: Colors.orange,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                                'Popularity: ${movie.popularity}'),
                                            const SizedBox(width: 10),
                                            const Icon(
                                              Icons.calendar_today,
                                              color: Colors.blue,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Release Date: ${movie.releaseDate}',
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Footer(),
                ],
              ),
            ),
    );
  }
}
