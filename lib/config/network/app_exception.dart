import 'dart:convert';

class AppException implements Exception {
  final dynamic errorResponse;

  AppException([this.errorResponse]);


  @override
  String toString() {
    return json.encode(errorResponse);
  }
}

class FetchDataException extends AppException {
  FetchDataException([dynamic errorResponse]) : super(errorResponse);
}

class BadRequestException extends AppException {
  BadRequestException([errorResponse]) : super(errorResponse);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([errorResponse]) : super(errorResponse);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? errorResponse]) : super(errorResponse);
}
