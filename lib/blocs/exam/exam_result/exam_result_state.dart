part of 'exam_result_bloc.dart';

@immutable
abstract class ExamResultState extends Equatable {
  const ExamResultState();

  @override
  List<Object> get props => [];
}

class ExamResultInitial extends ExamResultState {}

class ExamResultSendingState extends ExamResultState{}

class ExamResultSendErrorState extends ExamResultState{}

class ExamResultLoadedState extends ExamResultState{
  final double score;
 
  const ExamResultLoadedState({@required this.score});

  @override
  List<Object> get props => [score];
}
