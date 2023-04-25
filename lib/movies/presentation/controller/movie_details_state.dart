import 'package:equatable/equatable.dart';
import 'package:movie_app/core/utils/request_state.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/movie_recommendations_model.dart';
import 'package:movie_app/movies/domain/entities/movie_recommendations_entities.dart';

class MovieDetailsState extends Equatable {
  final MovieDetailsModel? detailsModel;
  final RequestState detailsState;
  final String detailsMessage;
  final List<MovieRecommendationsEntities> recommendationsModel;
  final RequestState recommendationsState;
  final String recommendationsMessage;

  const MovieDetailsState({
    this.detailsModel,
    this.detailsState = RequestState.loading,
    this.detailsMessage = "",
    this.recommendationsModel = const [],
    this.recommendationsState = RequestState.loading,
    this.recommendationsMessage = "",
  });

  MovieDetailsState copyWith({
    MovieDetailsModel? detailsModel,
    RequestState? detailsState,
    String? detailsMessage,
    List<MovieRecommendationsModel>? recommendationsModel,
    RequestState? recommendationsState,
    String? recommendationsMessage,
  }) {
    return MovieDetailsState(
      detailsModel: detailsModel ?? this.detailsModel,
      detailsState: detailsState ?? this.detailsState,
      detailsMessage: detailsMessage ?? this.detailsMessage,
      recommendationsModel: recommendationsModel ?? this.recommendationsModel,
      recommendationsState: recommendationsState ?? this.recommendationsState,
      recommendationsMessage:
      recommendationsMessage ?? this.recommendationsMessage,
    );
  }

  @override
  List<Object?> get props =>
      [
        detailsModel,
        detailsState,
        detailsMessage,
        recommendationsModel,
        recommendationsState,
        recommendationsMessage,
      ];
}
