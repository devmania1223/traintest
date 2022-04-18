part of 'exam_bloc.dart';

@immutable
abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {}

class ExamLoading extends ExamState {}

class ExamError extends ExamState {}

class ExamLoaded extends ExamState {
  final List<Problem> problems;
  const ExamLoaded({
    @required this.problems,
  }) : assert(problems != null);

  ExamLoaded copyWith({
    List<Problem> problems,
  }) {
    return ExamLoaded(
      problems: problems ?? this.problems,
    );
  }

  @override
  List<Object> get props => [problems];

  @override
  String toString() => 'ExamLoaded { messages: ${problems.length},}';
}

