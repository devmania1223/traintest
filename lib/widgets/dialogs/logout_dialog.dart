import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/auth/authentication/authentication_bloc.dart';

Future<void> logoutDialog(context, VoidCallback onPressed) {
  return showModal<void>(
    context: context,
    configuration: FadeScaleTransitionConfiguration(),
    builder: (context) => AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text(
        'Log out',
        style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: TextStyle(
            fontWeight: FontWeight.w400, color: Theme.of(context).primaryColor),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 90.0,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLoggedOut());
                },
              ),
            ),
            SizedBox(width: 15.0),
            SizedBox(
              width: 90.0,
              child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0)),
                    backgroundColor: Color(0xFF4A5568),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ],
    ),
  );
}
