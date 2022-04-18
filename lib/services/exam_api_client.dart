import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:educa_feedback/constants/api_constants.dart';
import 'package:educa_feedback/models/exam.dart';
import 'package:educa_feedback/preferences/preferences.dart';

class ExamApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  List<Exam> listModel = [];
  final http.Client httpClient;

  ExamApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Exam> fetchExamInfo(testId, type) async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/getProblems';

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          body: jsonEncode(
            <String, String>{
              'testId': testId.toString(),
              'type': type,
            },
          ),
        );
    
    if (response.statusCode != 200) {
      throw Exception('Error fetching .');
    }

    final result = jsonDecode(response.body);
    return Exam.fromJson(result);
  }

  Future<double> sendExamResult(problems, type) async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/sendExamResult';

    final response = await this.httpClient.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode(
        <String, String>{
          'problems': jsonEncode(problems),
          'type': type,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Error fetching .');
    }

    final result = jsonDecode(response.body)['data'];
    return result.toDouble();
  }


}
