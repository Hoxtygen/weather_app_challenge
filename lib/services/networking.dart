import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app_challenge/utils/app_exception.dart';
import 'package:weather_app_challenge/widgets/build_daily_widget.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final Uri url;

  Future<dynamic> getData() async {
    final responseJson;
    try {
      final response = await http.get(url);
      responseJson = _responseData(response);
    } on SocketException {
      throw Exception('error retrieving location');
    }
    return responseJson;
  }

  dynamic _responseData(http.Response response) {
    final   errorMessage;
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        errorMessage = json.decode(response.body);
        throw UnauthorizedException(normaliseName(errorMessage["message"]));
      case 404:
        errorMessage = json.decode(response.body);
        throw CityNotFoundException(normaliseName(errorMessage["message"]));
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
