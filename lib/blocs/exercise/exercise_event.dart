part of 'exercise_bloc.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();
}

class FetchExercise extends ExerciseEvent {
  @override
  List<Object> get props => [];
}
