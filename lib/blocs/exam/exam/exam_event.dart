part of 'exam_bloc.dart';

abstract class ExamEvent extends Equatable {
  const ExamEvent();
}

class FetchExam extends ExamEvent {
  final int testId;
  final String type;

  const FetchExam({
    @required this.testId,
    @required this.type,
    });

  @override
  List<Object> get props => [testId, type];

}
