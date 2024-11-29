import 'package:flutter/material.dart';
import 'package:flutter_web_app/pages/home_page.dart';
import 'package:flutter_web_app/pages/movie_details.dart';
import 'package:flutter_web_app/pages/movies_page.dart';
import 'package:flutter_web_app/pages/search.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomePage()),
      GoRoute(
          path: '/movies_page',
          builder: (context, state) => const MoviesPage()),
      GoRoute(
        path: '/search/:query',
        builder: (context, state) {
          final String query = state.pathParameters['query']!;
          return SearchPage(query: query);
        },
      ),
      GoRoute(
        path: '/movie/:id',
        builder: (context, state) {
          final String id = state.pathParameters['id']!;
          return MovieDetails(movieId: id);
        },
      ),
    ],
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routerConfig: _router,
    );
  }
}
