class ApiResponseData {
  int? statusCode;
  String? body;
  Map<String, String>? headers;

  ApiResponseData(this.statusCode, this.body, {
    this.headers
  });
}
