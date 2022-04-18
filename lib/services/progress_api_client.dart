import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:educa_feedback/constants/api_constants.dart';
import 'package:educa_feedback/models/progress.dart';
import 'package:educa_feedback/models/progress_bar.dart';
import 'package:educa_feedback/preferences/preferences.dart';

class ProgressApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  List<Progress> listModel = [];
  final http.Client httpClient;

  ProgressApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Progress> fetchProgressInfo() async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/getTopics';

    final response = await this.httpClient.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(
        <String, String>{
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching .');
    }

    final result = jsonDecode(response.body);
    return Progress.fromJson(result);
  }


  Future<ProgressBar> getProgressBarInfo() async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/getProgressBarInfo';

    final response = await this.httpClient.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(
        <String, String>{
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching .');
    }

    final result = jsonDecode(response.body);
    return ProgressBar.fromJson(result);
  }





}
