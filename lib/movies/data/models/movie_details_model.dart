import 'package:movie_app/movies/data/models/genres_model.dart';
import 'package:movie_app/movies/domain/entities/movie_details_entities.dart';

class MovieDetailsModel extends MovieDetailsEntities {
  const MovieDetailsModel({
    required super.genres,
    required super.backDropPath,
    required super.title,
    required super.overView,
    required super.id,
    required super.runTime,
    required super.releaseDate,
    required super.voteAverage,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      genres: List<GenresModel>.from(
          json['genres'].map((e) => GenresModel.fromJson(e))),
      backDropPath: json['backdrop_path'],
      title: json['title'],
      overView: json['overview'],
      id: json['id'],
      runTime: json['runtime'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
    );
  }
}
