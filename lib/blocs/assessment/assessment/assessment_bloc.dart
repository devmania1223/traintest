import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/models/test.dart';
import 'package:educa_feedback/repositories/assessment_repository.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentRepository assessmentRepository;

  AssessmentBloc({@required this.assessmentRepository})
      : assert(assessmentRepository != null),
        super(AssessmentInitial());

  @override
  Stream<AssessmentState> mapEventToState(
    AssessmentEvent event,
  ) async* {
    if (event is FetchAssessment) {
      yield* _mapFetchAssessmentToState(event);
    }
  }

  Stream<AssessmentState> _mapFetchAssessmentToState(FetchAssessment event) async* {
    try {
      yield AssessmentLoading();
      final page = await assessmentRepository.getAssessmentInfo();
      yield AssessmentLoaded(tests: page.tests);
    } catch (e) {
      print('error in assessment_bloc' + e);
      yield AssessmentError();
    }
  }


  
}
