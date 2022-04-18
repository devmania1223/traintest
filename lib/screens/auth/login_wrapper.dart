import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/auth/login/login_bloc.dart';
import 'package:educa_feedback/repositories/user_repository.dart';
import 'package:educa_feedback/screens/auth/login_screen.dart';

class LoginWrapper extends StatelessWidget {
  final UserRepository _userRepository;

  LoginWrapper({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userRepository: _userRepository),
      child: LoginScreen(),
    );
  }
}
