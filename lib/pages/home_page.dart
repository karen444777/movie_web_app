import 'package:flutter/material.dart';
import 'package:flutter_web_app/responsive.dart';
import 'package:flutter_web_app/models/movie_model.dart';
import 'package:flutter_web_app/services/movie_services.dart';
import 'package:flutter_web_app/widgets/drawer.dart';
import 'package:flutter_web_app/widgets/navbar.dart';
import 'package:flutter_web_app/widgets/skeleton/footer.dart';
import 'package:flutter_web_app/widgets/skeleton/now_playing_skeleton.dart';
import 'package:flutter_web_app/widgets/skeleton/popular_movies_skeleton.dart';
import '../widgets/home_widgets/now_playing_list.dart';
import '../widgets/home_widgets/popular_movies_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> topRatedMovies = [];
  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];
  bool isLoading = true;

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Responsive().isDesktop(context)
                ? const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 226, 22, 22),
                ),
              ),
            )
                : const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Top Rated Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 226, 39, 22),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: const Responsive().isDesktop(context)
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            'Now Playing',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 226, 39, 22),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 470,
                          child: isLoading
                              ? const NowPlayingSkeleton()
                              : NowPlayingList(
                              nowPlayingMovies: nowPlayingMovies),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  : Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Now Playing',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 226, 39, 22),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 470,
                          child: isLoading
                              ? const NowPlayingSkeleton()
                              : NowPlayingList(
                              nowPlayingMovies: nowPlayingMovies),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Explore Popular Movies',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color:Color.fromARGB(255, 226, 39, 22),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return isLoading
                      ? const PopularMoviesSkeleton()
                      : MovieGridView(movies: popularMovies);
                },
              ),
            ),
            const SizedBox(height: 8),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
