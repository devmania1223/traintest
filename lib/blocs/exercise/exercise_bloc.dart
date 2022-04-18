import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/models/test.dart';
import 'package:educa_feedback/repositories/exercise_repository.dart';

part 'exercise_event.dart';
part 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository exerciseRepository;

  ExerciseBloc({@required this.exerciseRepository})
      : assert(exerciseRepository != null),
        super(ExerciseInitial());

  @override
  Stream<ExerciseState> mapEventToState(
    ExerciseEvent event,
  ) async* {
    if (event is FetchExercise) {
      yield* _mapFetchExerciseToState(event);
    }
  }

  Stream<ExerciseState> _mapFetchExerciseToState(FetchExercise event) async* {
    try {
      yield ExerciseLoading();
      final page = await exerciseRepository.getExerciseInfo();
      yield ExerciseLoaded(tests: page.tests);
    } catch (e) {
      print('error in exercise_bloc' + e);
      yield ExerciseError();
    }
  }
}
