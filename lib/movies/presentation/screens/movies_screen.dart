import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/utils/colors_app.dart';
import 'package:movie_app/core/utils/ui_components.dart';
import 'package:movie_app/movies/presentation/components/get_now_playing_components.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movies_event.dart';
import 'package:movie_app/movies/presentation/controller/movies_state.dart';
import 'package:movie_app/movies/presentation/screens/popular_movies_screen.dart';
import 'package:movie_app/movies/presentation/screens/top_rated_movies_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: defaultColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const GetNoPlayingMoviesComponents(),
                    defaultSeeMore(
                      text: 'Popular',
                      screen: const PopularMoviesScreen(),
                      context: context,
                    ),
                    // const GetPopularMoviesComponents(),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: state.getPopular.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.getPopular.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = state.getPopular[index];
                                return buildListMovies(
                                  pathImage: movie.backDropPath!,
                                );
                              },
                            )
                          : Center(
                              child: defaultLoading(),
                            ),
                    ),

                    defaultSeeMore(
                      text: 'Top Rated',
                      screen: const TopRatedMoviesScreen(),
                      context: context,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: state.getTopRate.isNotEmpty
                          ? ListView.builder(
                              itemCount: state.getTopRate.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final movie = state.getTopRate[index];
                                return buildListMovies(
                                  pathImage: movie.backDropPath!,
                                );
                              },
                            )
                          : Center(
                              child: defaultLoading(),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
