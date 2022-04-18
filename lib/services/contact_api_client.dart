import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:educa_feedback/constants/api_constants.dart';
import 'package:educa_feedback/preferences/preferences.dart';

class ContactApiClient {
  static const baseUrl = ApiConstants.BASE_URL;
  final http.Client httpClient;

  // static final name = Prefer.prefs.getString('name');

  ContactApiClient({http.Client httpClient})
      : httpClient = httpClient ?? http.Client();

  Future<void> addContact({
    // String name,
    // String email,
    String subject,
    String description,
  }) async {
    final url = '$baseUrl/contact';

    final token = Prefer.prefs.getString('token');

    final response = await this.httpClient.post(
          Uri.parse(url),
          headers: requestHeaders(token),
          body: jsonEncode(
            <String, String>{
              // 'name': name,
              // 'email': email,
              'subject': subject,
              'description': description,
            },
          ),
        );
    if(response.statusCode != 200){
      throw Exception('Error Submmting Contact.');
    }
    return;
  }
}
