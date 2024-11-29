import 'package:flutter/material.dart';
import 'package:flutter_web_app/services/movie_services.dart';
import 'package:flutter_web_app/widgets/drawer.dart';
import 'package:flutter_web_app/widgets/navbar.dart';
import 'package:flutter_web_app/widgets/skeleton/footer.dart';
import 'package:flutter_web_app/widgets/skeleton/popular_movies_skeleton.dart';

import '../widgets/home_widgets/popular_movies_view.dart';
import '../models/movie_model.dart';
import '../widgets/movies_widget/movies_filter.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies = [];
  List<Movie> currentMovies = [];
  int selectedFilterIndex = 0;
  bool isLoading = true;

  void callback(int index, List<Movie> movies) {
    setState(() {
      selectedFilterIndex = index;
      currentMovies = movies;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    MovieServices movieServices = MovieServices();
    topRatedMovies = await movieServices.fetchTopRatedMovies();
    nowPlayingMovies = await movieServices.fetchNowPlayingMovies();
    popularMovies = await movieServices.fetchPopularMovies();
    upcomingMovies = await movieServices.fetchUpComingMovies();
    currentMovies = popularMovies;
    setState(() {
      isLoading = false;
    });
    // debugPrint(topRatedMovies[0].title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      'Explore Movies',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 226, 39, 22),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  MoviesFilter(
                    topRatedMovies: topRatedMovies,
                    nowPlayingMovies: nowPlayingMovies,
                    popularMovies: popularMovies,
                    upcomingMovies: upcomingMovies,
                    currentMovies: currentMovies,
                    callback: callback,
                    selectedFilterIndex: selectedFilterIndex,
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return isLoading
                          ? const PopularMoviesSkeleton()
                          : MovieGridView(movies: currentMovies);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
