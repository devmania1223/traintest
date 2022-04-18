part of 'exercise_bloc.dart';

@immutable
abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<Test> tests;
  const ExerciseLoaded({
    @required this.tests,
  }) : assert(tests != null);

  ExerciseLoaded copyWith({
    List<Test> tests,
  }) {
    return ExerciseLoaded(
      tests: tests ?? this.tests,
    );
  }

  @override
  List<Object> get props => [tests];

  @override
  String toString() => 'ExerciseLoaded { messages: ${tests.length},}';
}

class ExerciseError extends ExerciseState {}
