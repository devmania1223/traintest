// import 'dart:io';
import 'package:educa_feedback/services/contact_api_client.dart';
// import 'package:educa_feedback/models/contact.dart';

class ContactRepository {
  final ContactApiClient contactApiClient;

  ContactRepository({ContactApiClient contactApiClient})
      : contactApiClient = contactApiClient ?? ContactApiClient();

  Future<void> addContact({
    // String name,
    // String email,
    String subject,
    String description
  }) async {
    return contactApiClient.addContact(
      // name: name,
      // email: email,
      subject: subject,
      description: description,
    );
  }
}
