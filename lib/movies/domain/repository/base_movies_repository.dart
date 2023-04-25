import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/movie_recommendations_model.dart';
import 'package:movie_app/movies/data/models/movies_model.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendations_movie_use_case.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<MoviesModel>>> getNowPlayingMovies();

  Future<Either<Failure, List<MoviesModel>>> getTopRatedMovies();

  Future<Either<Failure, List<MoviesModel>>> getPopularMovies();

  Future<Either<Failure, MovieDetailsModel>> getMovieDetails(
      MovieDetailsParameters parameters);

  Future<Either<Failure, List<MovieRecommendationsModel>>>
      getMovieRecommendations(RecommendationsParameters parameter);
}
