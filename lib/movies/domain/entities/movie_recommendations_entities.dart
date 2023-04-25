import 'package:equatable/equatable.dart';

class MovieRecommendationsEntities extends Equatable {
  final String? backDropPath;
  final int id;

  const MovieRecommendationsEntities({
    this.backDropPath,
    required this.id,
  });

  @override
  List<Object?> get props => [
        backDropPath??'',
        id,
      ];
}
