import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/repositories/assessment_repository.dart';

part 'access_code_event.dart';
part 'access_code_state.dart';

class AccessCodeBloc extends Bloc<AccessCodeEvent, AccessCodeState> {
  final AssessmentRepository assessmentRepository;

  AccessCodeBloc({@required this.assessmentRepository})
      : assert(assessmentRepository != null),
        super(AccessCodeInitial());

  @override
  Stream<AccessCodeState> mapEventToState(
    AccessCodeEvent event,
  ) async* {
    if(event is SendAccessCodeEvent){
      yield* _mapSendAccessCodeEventToState(event);
    }
  }

  Stream<AccessCodeState> _mapSendAccessCodeEventToState(SendAccessCodeEvent event) async*{
    try {
      yield AccessCodeSendingState();
      final verify =  await assessmentRepository.verifyAccessCode(event.assessmentId, event.accessCode);
      yield AccessCodeLoadedState(verify : verify);
    }catch(e) {
      print('error in exam_block' + e);
      yield AccessCodeSendErrorState();
    }
  }
}
