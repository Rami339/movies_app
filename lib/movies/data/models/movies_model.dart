import 'package:movie_app/movies/domain/entities/movies_entities.dart';

class MoviesModel extends MoviesEntities {
  const MoviesModel({
    required super.id,
   super.backDropPath,
    required super.title,
    required super.releaseDate,
    required super.voteAverage,
    required super.genreId,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'],
      backDropPath: json['backdrop_path'],
      title: json['title'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
      genreId: List<int>.from((json['genre_ids']).map((e) => e)),
    );
  }
}
