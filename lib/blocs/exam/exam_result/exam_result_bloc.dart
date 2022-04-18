import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/models/problem.dart';
import 'package:educa_feedback/repositories/exam_repository.dart';

part 'exam_result_event.dart';
part 'exam_result_state.dart';

class ExamResultBloc extends Bloc<ExamResultEvent, ExamResultState> {
  final ExamRepository examRepository;

  ExamResultBloc({@required this.examRepository})
      : assert(examRepository != null),
        super(ExamResultInitial());

  @override
  Stream<ExamResultState> mapEventToState(
    ExamResultEvent event,
  ) async* {
    if(event is SendExamResultEvent){
      yield* _mapSendExamResultEventToState(event);
    }
  }

  Stream<ExamResultState> _mapSendExamResultEventToState(SendExamResultEvent event) async*{
    try {
      yield ExamResultSendingState();
      final score =  await examRepository.sendExamResult(event.problems, event.type);
      yield ExamResultLoadedState(score : score);
    }catch(e) {
      print('error in exam_block' + e);
      yield ExamResultSendErrorState();
    }
  }
}
