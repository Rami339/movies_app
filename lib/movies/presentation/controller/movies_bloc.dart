import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/base_use_case.dart';
import 'package:movie_app/core/utils/request_state.dart';
import 'package:movie_app/movies/domain/use_case/get_now_playing_movies_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_popular_movies_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_top_rated_movies_use_case.dart';
import 'package:movie_app/movies/presentation/controller/movies_event.dart';
import 'package:movie_app/movies/presentation/controller/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  static MoviesBloc get(context) => BlocProvider.of(context);
  final GetNowPlayingMoviesUseCase nowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase popularMoviesUseCase;
  final GetTopRatedMoviesUseCase topRatedMoviesUseCase;

  MoviesBloc(
    this.popularMoviesUseCase,
    this.nowPlayingMoviesUseCase,
    this.topRatedMoviesUseCase,
  ) : super(const MoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlaying);
    on<GetTopRatedMoviesEvent>(_getTopRated);
    on<GetPopularMoviesEvent>(_getPopular);
  }

  FutureOr<void> _getNowPlaying(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await nowPlayingMoviesUseCase(const NoParameters());
    result.fold(
      (l) async {
        emit(state.copyWith(
          nowPlayingMessage: l.message,
          nowPlayingState: RequestState.error,
        ));
      },
      (r) {
        emit(
          state.copyWith(
            getNowPlaying: r,
            nowPlayingState: RequestState.loaded,
          ),
        );
      },
    );
  }

  FutureOr<void> _getTopRated(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await topRatedMoviesUseCase(const NoParameters());

    result.fold((l) {
      emit(state.copyWith(
        topRateMessage: l.message,
        topRateState: RequestState.error,
      ));
    }, (r) {
      emit(state.copyWith(
        getTopRate: r,
        topRateState: RequestState.loaded,
      ));
    });
  }

  FutureOr<void> _getPopular(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await popularMoviesUseCase(const NoParameters());
    result.fold((l) {
      emit(state.copyWith(
        popularMessage: l.message,
        popularState: RequestState.error,
      ));
    }, (r) {
      emit(state.copyWith(
        getPopular: r,
        popularState: RequestState.loaded,
      ));
    });
  }

}
