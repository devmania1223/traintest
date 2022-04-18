part of 'exam_result_bloc.dart';

abstract class ExamResultEvent extends Equatable {
  const ExamResultEvent();
}

class SendExamResultEvent extends ExamResultEvent {
  final List<Problem> problems;
  final String type;

  SendExamResultEvent({
    @required this.problems,
    @required this.type,
    });

  @override
  List<Object> get props => [problems, type];

}
