import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:educa_feedback/constants/api_constants.dart';
import 'package:educa_feedback/models/grades.dart';
import 'package:educa_feedback/preferences/preferences.dart';

class GradesApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  List<Grades> listModel = [];
  final http.Client httpClient;

  GradesApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Grades> fetchGradesInfo() async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/fetchGradesInfo';

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
    return Grades.fromJson(result);
  }


  



}
