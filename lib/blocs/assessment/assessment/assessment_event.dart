part of 'assessment_bloc.dart';

abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();
}

class FetchAssessment extends AssessmentEvent {
  @override
  List<Object> get props => [];
}
