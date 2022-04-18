import 'dart:io';

import 'package:educa_feedback/models/notifications.dart';
import 'package:educa_feedback/models/notifications.dart';
import 'package:educa_feedback/preferences/preferences.dart';
import 'package:educa_feedback/services/notifications_api_client.dart';

class NotificationsRepository {
  final NotificationsApiClient notificationsApiClient;

  NotificationsRepository({NotificationsApiClient notificationsApiClient})
      : notificationsApiClient =
            notificationsApiClient ?? NotificationsApiClient();

  Future<Notifications> getNotificationsInfo() async {
    return notificationsApiClient.fetchNotificationsInfo();
  }
}
