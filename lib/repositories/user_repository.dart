import 'dart:io';

import 'package:educa_feedback/models/auth.dart';
import 'package:educa_feedback/models/user.dart';
import 'package:educa_feedback/preferences/preferences.dart';
import 'package:educa_feedback/services/user_api_client.dart';

class UserRepository {
  final UserApiClient userApiClient;

  UserRepository({UserApiClient userApiClient})
      : userApiClient = userApiClient ?? UserApiClient();

  Future<Auth> loginWithCredentials(String email, String password) async {
    return userApiClient.login(email: email, password: password);
  }

  Future<bool> isSignedIn() async {
    final token = Prefer.prefs.getString('token');
    return token != null;
  }

  Future<void> logOut() async {
    final token = Prefer.prefs.getString('token');
    userApiClient.logout(token);
    Prefer.prefs.clear();
  }

  // Future<Auth> register(
  //   String name,
  //   String username,
  //   String email,
  //   String password,
  //   String passwordConfirmation,
  // ) async {
  //   // String fcmToken = await getFcmtoken();

  //   return userApiClient.register(
  //     name: name,
  //     username: username,
  //     email: email,
  //     password: password,
  //     passwordConfirmation: passwordConfirmation,
  //   );
  // }

  Future<User> getAuthUserInfo() async {
    return userApiClient.fetchAuthInfo();
  }

  Future<User> getUserInfo(String userName) async {
    return userApiClient.fetchUserInfo(userName);
  }

  Future<String> updatePassword(String oldPassword, String newPassword,
      String newPasswordConfirmation) async {
    return userApiClient.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation);
  }

  Future<User> updateEmail(String password, String email) async {
    return userApiClient.updateEmail(
      password: password,
      email: email,
    );
  }

  Future<User> updateProfile({
    String email,
    File photo,
  }) async {
    return userApiClient.editProfile(
      email: email,
      // username: username,
      // description: description,
      photo: photo,
      // banner: banner,
    );
  }

  // Future<String> getFcmtoken() async {
  //   final FirebaseMessaging fcm = FirebaseMessaging();
  //   String fcmToken = await fcm.getToken();

  //   Prefer.prefs.setString('fcmToken', fcmToken);
  //   print("FCM_TOKEN: " + fcmToken);

  //   return fcmToken;
  // }

  Future<void> requestPasswordResetInfo(String email) async {
    return userApiClient.requestPasswordResetInfo(email);
  }

  Future<void> requestCodeResetInfo(String code) async {
    return userApiClient.requestCodeResetInfo(code);
  }

  Future<void> requestNotificationInfo(String email) async {
    return userApiClient.requestNotificationInfo(email);
  }

  Future<String> getAvatar() async {
    return userApiClient.getAvatar();
  }

  Future<List<User>> explore() async {
    return userApiClient.explore();
  }

  Future<List<User>> findMentionedUsers(String query) async {
    return userApiClient.findMentionedUser(query);
  }

  Future<void> uploadImages({File photo}) async {
    return userApiClient.uploadImages(photo: photo);
  }
}
