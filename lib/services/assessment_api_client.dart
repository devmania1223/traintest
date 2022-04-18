import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:educa_feedback/constants/api_constants.dart';

import 'package:educa_feedback/models/assessment.dart';
import 'package:educa_feedback/preferences/preferences.dart';

class AssessmentApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  List<Assessment> listModel = [];
  final http.Client httpClient;

  AssessmentApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Assessment> fetchAssessmentInfo() async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/getTests';

    String type = "Assessment";

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          body: jsonEncode(
            <String, String>{
              'type': type,
            },
          ),
        );

    if (response.statusCode != 200) {
      throw Exception('Error fetching assessment.');
    }
    final result = jsonDecode(response.body);

    return Assessment.fromJson(result);
  }

  Future<bool> verifyAccessCode(assessmentId, accessCode) async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/verifyAccessCode';

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          body: jsonEncode(
            <String, String>{
              'assessmentId': assessmentId.toString(),
              'accessCode': accessCode,
            },
          ),
        );

    if (response.statusCode != 200) {
      throw Exception('Error Verify Access Code.');
    }
    final result = jsonDecode(response.body)['data'];

    return result;
  }




}
