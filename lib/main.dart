import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:educa_feedback/blocs/auth/authentication/authentication_bloc.dart';
import 'package:educa_feedback/blocs/simple_bloc_observer.dart';
import 'package:educa_feedback/preferences/preferences.dart';

import 'package:educa_feedback/repositories/repositories.dart';
import 'package:educa_feedback/tweety.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  int initialThemeIndex =
      WidgetsBinding.instance.window.platformBrightness == Brightness.light
          ? 0 : 1;

  Prefer.prefs = await SharedPreferences.getInstance();
  Prefer.themeIndexPref = Prefer.prefs.getInt('theme') ?? initialThemeIndex;

  final UserRepository userRepository = UserRepository();
  final ContactRepository contactRepository = ContactRepository();
  final ProgressRepository progressRepository = ProgressRepository();
  final GradesRepository gradesRepository = GradesRepository();

  final ExerciseRepository exerciseRepository = ExerciseRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AuthenticationStarted()),
      child: Tweety(
        userRepository: userRepository,
        contactRepository: contactRepository,
        exerciseRepository: exerciseRepository,
        progressRepository: progressRepository,
        gradesRepository: gradesRepository,
      ),
    ),
  );
}
