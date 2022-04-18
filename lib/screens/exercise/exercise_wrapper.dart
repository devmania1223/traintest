import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:educa_feedback/blocs/exercise/exercise_bloc.dart';
import 'package:educa_feedback/screens/exercise/exercise_screen.dart';

class ExerciseWrapper extends StatelessWidget {
  const ExerciseWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: context.watch<ExerciseBloc>(),
      child: ExerciseScreen(),
    );
  }
}
