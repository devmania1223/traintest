import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:educa_feedback/constants/api_constants.dart';
import 'package:educa_feedback/models/exercise.dart';
import 'package:educa_feedback/preferences/preferences.dart';

class ExerciseApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  List<Exercise> listModel = [];
  final http.Client httpClient;

  ExerciseApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<Exercise> fetchExerciseInfo() async {
    final token = Prefer.prefs.getString('token');

    final url = '$baseUrl/getTests';
    String type = "Exercise";

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
      throw Exception('Error fetching .');
    }

    final result = jsonDecode(response.body);
    return Exercise.fromJson(result);
  }
}
