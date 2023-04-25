import 'package:movie_app/movies/domain/entities/genres_entities.dart';

class GenresModel extends GenresEntities {
  const GenresModel({
    required super.id,
    required super.name,
  });

  factory GenresModel.fromJson(Map<String, dynamic> json) {
    return GenresModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
