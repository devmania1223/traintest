import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/profile/profile/profile_bloc.dart';
import 'package:educa_feedback/screens/profile/profile_screen.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context).settings.arguments;

    return BlocProvider.value(
      value: context.watch<ProfileBloc>(),
      child: ProfileScreen(
        email: email,
      ),
    );
  }
}
