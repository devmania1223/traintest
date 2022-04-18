import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:educa_feedback/constants/api_constants.dart';
import 'package:educa_feedback/models/auth.dart';
import 'package:educa_feedback/models/notifications.dart';
import 'package:educa_feedback/preferences/preferences.dart';
import 'package:http_parser/http_parser.dart';

class NotificationsApiClient {
  static const baseUrl = ApiConstants.BASE_URL;

  final http.Client httpClient;
  NotificationsApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();
  Future<void> requestNotificationInfo(String email) async {
    final url = '$baseUrl/notifications';
    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          body: jsonEncode(
            <String, String>{
              'email': email,
            },
          ),
        );
    if (response.statusCode == 422) {
      var errorMessage = jsonDecode(response.body)['message'];
      throw Exception(errorMessage);
    } else if (response.statusCode != 200) {
      throw Exception('Unable to send password reset info!');
    }
    Prefer.prefs.setString('forgotEmail', email);

    return;
  }

  Future<Notifications> fetchNotificationsInfo() async {
    final url = '$baseUrl/notifications';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.get(
          Uri.parse(url),
          headers: requestHeaders(token),
        );

    if (response.statusCode != 200) {
      throw Exception('Error fetching notifications.');
    }

    final notificationsJson = jsonDecode(response.body)['data'];

    return Notifications.fromJson(notificationsJson);
  }
}
