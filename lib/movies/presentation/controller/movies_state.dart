import 'package:equatable/equatable.dart';
import 'package:movie_app/core/utils/request_state.dart';
import 'package:movie_app/movies/data/models/movies_model.dart';

class MoviesState extends Equatable {
  final List<MoviesModel> getNowPlaying;
  final RequestState nowPlayingState;
  final String nowPlayingMessage;
  final List<MoviesModel> getTopRate;
  final RequestState topRateState;
  final String topRateMessage;
  final List<MoviesModel> getPopular;
  final RequestState popularState;
  final String popularMessage;

  const MoviesState({
    this.getNowPlaying = const [],
    this.nowPlayingState = RequestState.loading,
    this.nowPlayingMessage = "",
    this.getTopRate = const [],
    this.topRateState = RequestState.loading,
    this.topRateMessage = "",
    this.getPopular = const [],
    this.popularState = RequestState.loading,
    this.popularMessage = "",
  });

  MoviesState copyWith({
    List<MoviesModel>? getNowPlaying,
    RequestState? nowPlayingState,
    String? nowPlayingMessage,
    List<MoviesModel>? getTopRate,
    RequestState? topRateState,
    String? topRateMessage,
    List<MoviesModel>? getPopular,
    RequestState? popularState,
    String? popularMessage,
  }) {
    return MoviesState(
      getNowPlaying: getNowPlaying ?? this.getNowPlaying,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      getTopRate: getTopRate ?? this.getTopRate,
      topRateState: topRateState ?? this.topRateState,
      topRateMessage: topRateMessage ?? this.topRateMessage,
      getPopular: getPopular ?? this.getPopular,
      popularState: popularState ?? this.popularState,
      popularMessage: popularMessage ?? this.popularMessage,
    );
  }

  @override
  List<Object> get props =>
      [
        getNowPlaying,
        nowPlayingState,
        nowPlayingMessage,
        getTopRate,
        topRateState,
        topRateMessage,
        getPopular,
        popularState,
        popularMessage,
      ];
}
