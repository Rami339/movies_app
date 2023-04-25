import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/utils/base_use_case.dart';
import 'package:movie_app/movies/data/models/movie_recommendations_model.dart';
import 'package:movie_app/movies/domain/repository/base_movies_repository.dart';

class GetRecommendationMovieMovieUseCase
    extends BaseUseCase<List<MovieRecommendationsModel>, RecommendationsParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetRecommendationMovieMovieUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<MovieRecommendationsModel>>> call(
      RecommendationsParameters parameters) async {
    return await baseMoviesRepository.getMovieRecommendations(parameters);
  }
}

class RecommendationsParameters extends Equatable {
  final int movieId;



  const RecommendationsParameters(this.movieId);

  @override
  List<Object> get props => [movieId];
}
