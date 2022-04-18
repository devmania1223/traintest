part of 'progress_bloc.dart';

abstract class ProgressEvent extends Equatable {
  const ProgressEvent();
}

class FetchProgress extends ProgressEvent {
  @override
  List<Object> get props => [];
}
