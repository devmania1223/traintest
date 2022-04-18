part of 'access_code_bloc.dart';

abstract class AccessCodeEvent extends Equatable {
  const AccessCodeEvent();
}

class SendAccessCodeEvent extends AccessCodeEvent {
  final int assessmentId;
  final String accessCode;

  SendAccessCodeEvent({@required this.assessmentId, @required this.accessCode});

  @override
  List<Object> get props => [assessmentId, accessCode];

}
