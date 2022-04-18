part of 'access_code_bloc.dart';

@immutable
abstract class AccessCodeState extends Equatable {
  const AccessCodeState();

  @override
  List<Object> get props => [];
}

class AccessCodeInitial extends AccessCodeState {}

class AccessCodeSendingState extends AccessCodeState{}

class AccessCodeSendErrorState extends AccessCodeState{}

class AccessCodeLoadedState extends AccessCodeState{
  final bool verify;
 
  const AccessCodeLoadedState({@required this.verify});

  @override
  List<Object> get props => [verify];
}
