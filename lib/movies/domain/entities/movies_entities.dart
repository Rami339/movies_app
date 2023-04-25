import 'package:equatable/equatable.dart';

class MoviesEntities extends Equatable {
  final int id;
  final String? backDropPath;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final List<int> genreId;

  const MoviesEntities({
    required this.id,
     this.backDropPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreId,
  });

  @override
  List<Object?> get props => [
        id,
        backDropPath??'',
        title,
        releaseDate,
        voteAverage,
        genreId,
      ];
}
