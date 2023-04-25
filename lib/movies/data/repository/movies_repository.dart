import 'package:movie_app/core/error/failure.dart';
import 'package:movie_app/core/error/movies_exception.dart';
import 'package:movie_app/movies/data/data_source/Movies_remote_data_source.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/movie_recommendations_model.dart';
import 'package:movie_app/movies/data/models/movies_model.dart';
import 'package:movie_app/movies/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendations_movie_use_case.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMoviesRemoteDataSource baseMoviesRemoteDataSource;

  MoviesRepository(this.baseMoviesRemoteDataSource);

  @override
  Future<Either<Failure, List<MoviesModel>>> getNowPlayingMovies() async {
    final result = await baseMoviesRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessage.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MoviesModel>>> getPopularMovies() async {
    final result = await baseMoviesRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(
          failure.moviesErrorMessage.statusMessage,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<MoviesModel>>> getTopRatedMovies() async {
    final result = await baseMoviesRemoteDataSource.getTopRatedMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        failure.moviesErrorMessage.statusMessage,
      ));
    }
  }

  @override
  Future<Either<Failure, MovieDetailsModel>> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final result = await baseMoviesRemoteDataSource.getMovieDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        failure.moviesErrorMessage.statusMessage,
      ));
    }
  }

  @override
  Future<Either<Failure, List<MovieRecommendationsModel>>>
      getMovieRecommendations(RecommendationsParameters parameter) async{
    final result = await baseMoviesRemoteDataSource.getMovieRecommendations(parameter);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(
        failure.moviesErrorMessage.statusMessage,
      ));
    }
  }
}
