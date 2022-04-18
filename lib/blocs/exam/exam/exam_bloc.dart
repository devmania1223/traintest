import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/models/problem.dart';
import 'package:educa_feedback/repositories/exam_repository.dart';

part 'exam_event.dart';
part 'exam_state.dart';

class ExamBloc extends Bloc<ExamEvent, ExamState> {
  final ExamRepository examRepository;

  ExamBloc({@required this.examRepository})
      : assert(examRepository != null),
        super(ExamInitial());

  @override
  Stream<ExamState> mapEventToState(
    ExamEvent event,
  ) async* {
    if (event is FetchExam) {
      yield* _mapFetchExamToState(event);
    }
  }

  Stream<ExamState> _mapFetchExamToState(FetchExam event) async* {
    try {
      yield ExamLoading();
      final result = await examRepository.getExamInfo(event.testId, event.type);
      yield ExamLoaded(problems: result.problems);
    } catch (e) {
      print('error in exam_bloc' + e);
      yield ExamError();
    }
  }







}