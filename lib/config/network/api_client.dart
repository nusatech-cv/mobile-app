import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pijetin/config/network/app_exception.dart';
import 'package:pijetin/data/environment/environmet.dart';
import 'package:pijetin/data/model/model.dart';

class ApiClient {
  final String _baseUrl = Environment.getApiBaseUrl();
  final String? _appVersion = Environment.getApiAppVersion();
  Map<String, String>? headers;

  Future<ApiResponseData> get(String url) async {
    ApiResponseData responseJson;

    try {
      final response = await http.get(
          Uri.parse(
            (_baseUrl + _appVersion!) + url,
          ),
          headers: headers);

      

      responseJson = ApiResponseData(response.statusCode, response.body,
          headers: response.headers);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }

    return responseJson;
  }

  Future<ApiResponseData> post(String url, dynamic body) async {
    ApiResponseData responseJson;

    try {
      final response = await http.post(
          Uri.parse(
            _baseUrl + _appVersion! + url,
          ),
          body: jsonEncode(body),
          headers: headers);

      responseJson = ApiResponseData(response.statusCode, response.body,
          headers: response.headers);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }

  Future<ApiResponseData> patch(String url, dynamic body) async {
    ApiResponseData responseJson;
    try {
      log("body : ${jsonEncode(body)}");

      final response = await http.patch(
          Uri.parse(_baseUrl + _appVersion! + url),
          body: jsonEncode(body),
          headers: headers);

      responseJson = ApiResponseData(response.statusCode, response.body,
          headers: response.headers);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }

  Future<ApiResponseData> put(String url, dynamic body) async {
    ApiResponseData responseJson;
    try {
      final response = await http.put(Uri.parse(_baseUrl + _appVersion! + url),
          body: jsonEncode(body), headers: headers);

      responseJson = ApiResponseData(response.statusCode, response.body,
          headers: response.headers);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }

  Future<ApiResponseData> delete(String url) async {
    ApiResponseData responseJson;
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + _appVersion! + url),
        headers: headers,
      );
      responseJson = ApiResponseData(response.statusCode, response.body,
          headers: response.headers);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }

  Future<ApiResponseData> deleteWithBody(String url, dynamic body) async {
    ApiResponseData responseJson;
    try {
      final response = await http.delete(
          Uri.parse(_baseUrl + _appVersion! + url),
          headers: headers,
          body: body);
      responseJson = ApiResponseData(response.statusCode, response.body,
          headers: response.headers);
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }

  Future<ApiResponseData> multiPart(http.MultipartRequest request) async {
    ApiResponseData responseJson;
    try {
      final response = await request.send();
      final res = await http.Response.fromStream(response);
      responseJson =
          ApiResponseData(res.statusCode, res.body, headers: res.headers);
      log("response multipart => $responseJson");
    } on SocketException {
      throw FetchDataException({
        'statusCode': 1,
        'errors': ['server.not.available']
      });
    } on HttpException {
      throw FetchDataException({
        'statusCode': 2,
        'errors': ['no.internet']
      });
    } on FormatException {
      throw FetchDataException({
        'statusCode': 3,
        'errors': ['server.error']
      });
    }
    return responseJson;
  }
}
