import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/request_state.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendations_movie_use_case.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_event.dart';
import 'package:movie_app/movies/presentation/controller/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendationMovieMovieUseCase getRecommendationMovieUseCase;

  MovieDetailsBloc(
    this.getMovieDetailsUseCase,
    this.getRecommendationMovieUseCase,
  ) : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetRecommendationMovieEvent>(_getRecommendationMovie);
  }

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await getMovieDetailsUseCase(MovieDetailsParameters(event.id));

    result.fold(
      (l) {
        emit(state.copyWith(
          detailsState: RequestState.error,
          detailsMessage: l.message,
        ));
      },
      (r) {
        emit(
            state.copyWith(detailsState: RequestState.loaded, detailsModel: r));
      },
    );
  }

  FutureOr<void> _getRecommendationMovie(GetRecommendationMovieEvent event,
      Emitter<MovieDetailsState> emit) async {
    final result = await getRecommendationMovieUseCase(
        RecommendationsParameters(event.id));

    result.fold(
      (l) {
        emit(state.copyWith(
          recommendationsState: RequestState.error,
          recommendationsMessage: l.message,
        ));
      },
      (r) {
        emit(
          state.copyWith(
            recommendationsState: RequestState.loaded,
            recommendationsModel: r,
          ),
        );
      },
    );
  }
}
