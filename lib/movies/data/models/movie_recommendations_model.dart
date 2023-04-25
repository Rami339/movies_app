import 'package:movie_app/movies/domain/entities/movie_recommendations_entities.dart';

class MovieRecommendationsModel extends MovieRecommendationsEntities {
  const MovieRecommendationsModel({
    super.backDropPath,
    required super.id,
  });

  factory MovieRecommendationsModel.fromJson(Map<String, dynamic> json) {
    return MovieRecommendationsModel(
      backDropPath: json['backdrop_path'],
      id: json['id'],
    );
  }
}
