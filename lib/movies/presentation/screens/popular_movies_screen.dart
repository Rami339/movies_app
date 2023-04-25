import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/services/services_locator.dart';
import 'package:movie_app/core/utils/colors_app.dart';
import 'package:movie_app/core/utils/ui_components.dart';
import 'package:movie_app/movies/presentation/controller/movies_bloc.dart';
import 'package:movie_app/movies/presentation/controller/movies_event.dart';
import 'package:movie_app/movies/presentation/controller/movies_state.dart';

class PopularMoviesScreen extends StatelessWidget {
  const PopularMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()..add(GetPopularMoviesEvent()),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state.getPopular.isNotEmpty) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar:buildAppbarMovie(title: 'Popular Movies', context: context, ),
              backgroundColor: anotherGeryDarkColor,
              body: ListView.builder(
                  itemCount: state.getPopular.length,
                  itemBuilder: (context, index) {
                    final popular = state.getPopular[index];
                    return buildMovie(
                      pathImage: popular.backDropPath!,
                      name: popular.title,
                      title: popular.title,
                      releaseDate: popular.releaseDate,
                      voteAverage: popular.voteAverage,
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
