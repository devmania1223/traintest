part of 'assessment_bloc.dart';

@immutable
abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object> get props => [];
}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentLoaded extends AssessmentState {
  final List<Test> tests;
  const AssessmentLoaded({
    @required this.tests,
  }) : assert(tests != null);

  AssessmentLoaded copyWith({
    List<Test> tests,
  }) {
    return AssessmentLoaded(
      tests: tests ?? this.tests,
    );
  }

  @override
  List<Object> get props => [tests];

  @override
  String toString() => 'AssessmentLoaded { messages: ${tests.length},}';
}

class AssessmentError extends AssessmentState {}
