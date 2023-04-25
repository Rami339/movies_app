import 'package:equatable/equatable.dart';
import 'package:movie_app/core/network/movies_error_message.dart';

class ServerException extends Equatable {
  final MoviesErrorMessage moviesErrorMessage;

  const ServerException({required this.moviesErrorMessage});

  @override
  List<Object> get props => [
        moviesErrorMessage,
      ];
}
