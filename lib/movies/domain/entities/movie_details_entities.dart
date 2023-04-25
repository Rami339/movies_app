import 'package:equatable/equatable.dart';
import 'package:movie_app/movies/domain/entities/genres_entities.dart';

class MovieDetailsEntities extends Equatable {
  final List<GenresEntities> genres;
  final String backDropPath;
  final String title;
  final String overView;
  final String releaseDate;
  final int id;
  final num runTime;
  final dynamic voteAverage;

  const MovieDetailsEntities({
    required this.genres,
    required this.backDropPath,
    required this.title,
    required this.overView,
    required this.id,
    required this.runTime,
    required this.releaseDate,
    required this.voteAverage,
  });

  @override
  List<Object> get props => [
        backDropPath,
        title,
        overView,
        id,
        runTime,
        releaseDate,
        genres,
    voteAverage
  ];
}
