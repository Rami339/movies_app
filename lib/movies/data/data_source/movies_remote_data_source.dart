import 'package:dio/dio.dart';
import 'package:movie_app/core/error/movies_exception.dart';
import 'package:movie_app/core/network/api_constance.dart';
import 'package:movie_app/core/network/movies_error_message.dart';
import 'package:movie_app/movies/data/models/movie_details_model.dart';
import 'package:movie_app/movies/data/models/movie_recommendations_model.dart';
import 'package:movie_app/movies/data/models/movies_model.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendations_movie_use_case.dart';

abstract class BaseMoviesRemoteDataSource {
  Future<List<MoviesModel>> getNowPlayingMovies();

  Future<List<MoviesModel>> getPopularMovies();

  Future<List<MoviesModel>> getTopRatedMovies();

  Future<MovieDetailsModel> getMovieDetails(MovieDetailsParameters parameters);

  Future<List<MovieRecommendationsModel>> getMovieRecommendations(
      RecommendationsParameters parameters);
}

class MoviesRemoteDataSource extends BaseMoviesRemoteDataSource {
  @override
  Future<List<MoviesModel>> getNowPlayingMovies() async {
    final response = await Dio().get(ApiConstance.getNowPlayingNetwork);
    if (response.statusCode == 200) {
      return List<MoviesModel>.from(
          (response.data['results']).map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException(
        moviesErrorMessage: MoviesErrorMessage.fromJson(
          response.data,
        ),
      );
    }
  }

  @override
  Future<List<MoviesModel>> getPopularMovies() async {
    final response = await Dio().get(ApiConstance.getPopularNetwork);
    if (response.statusCode == 200) {
      return List<MoviesModel>.from(
          (response.data['results']).map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException(
        moviesErrorMessage: MoviesErrorMessage.fromJson(
          response.data,
        ),
      );
    }
  }

  @override
  Future<List<MoviesModel>> getTopRatedMovies() async {
    final response = await Dio().get(ApiConstance.getTopRatedNetwork);
    if (response.statusCode == 200) {
      return List<MoviesModel>.from(
          (response.data['results']).map((e) => MoviesModel.fromJson(e)));
    } else {
      throw ServerException(
        moviesErrorMessage: MoviesErrorMessage.fromJson(
          response.data,
        ),
      );
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.getDetailsNetwork(parameters.movieId));

    if (response.statusCode == 200) {
      return MovieDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
          moviesErrorMessage: MoviesErrorMessage.fromJson(response.data));
    }
  }

  @override
  Future<List<MovieRecommendationsModel>> getMovieRecommendations(
      RecommendationsParameters parameters) async {
    final response = await Dio()
        .get(ApiConstance.getRecommendationsNetwork(parameters.movieId));
    if (response.statusCode == 200) {
      return List<MovieRecommendationsModel>.from(
          (response.data['results']).map((e) => MovieRecommendationsModel.fromJson(e)));
    } else {
      throw ServerException(
        moviesErrorMessage: MoviesErrorMessage.fromJson(
          response.data,
        ),
      );
    }

  }

}
