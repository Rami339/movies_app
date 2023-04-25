import 'package:equatable/equatable.dart';

class MoviesErrorMessage extends Equatable {
  final int statusCode;
  final String statusMessage;
  final bool success;

  const MoviesErrorMessage({
    required this.statusCode,
    required this.statusMessage,
    required this.success,
  });

  factory MoviesErrorMessage.fromJson(Map<String, dynamic> json) {
    return MoviesErrorMessage(
      statusCode: json['status_code'],
      statusMessage: json['status_message'],
      success: json['success'],
    );
  }

  @override
  List<Object> get props => [
        statusCode,
        statusMessage,
        success,
      ];
}
