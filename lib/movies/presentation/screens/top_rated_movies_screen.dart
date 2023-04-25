import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/utils/colors_app.dart';
import 'package:movie_app/core/utils/ui_components.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movies_event.dart';
import 'package:movie_app/movies/presentation/controller/movies_state.dart';

class TopRatedMoviesScreen extends StatelessWidget {
  const TopRatedMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()..add(GetTopRatedMoviesEvent()),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state.getTopRate.isNotEmpty) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar:buildAppbarMovie(title: 'Top Rated Movies', context: context, ),
              backgroundColor: anotherGeryDarkColor,
              body: ListView.builder(
                  itemCount: state.getTopRate.length,
                  itemBuilder: (context, index) {
                    final topRated = state.getTopRate[index];
                    return buildMovie(
                      pathImage: topRated.backDropPath!,
                      name: topRated.title,
                      title: topRated.title,
                      releaseDate: topRated.releaseDate,
                      voteAverage: topRated.voteAverage,
                    );
                  }),
            );
          } else {
            return Scaffold(
              backgroundColor: anotherGeryDarkColor,
              body: Center(
                child: defaultLoading(),
              ),
            );
          }
        },
      ),
    );
  }
}
