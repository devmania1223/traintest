part of 'progress_bar_bloc.dart';

abstract class ProgressBarEvent extends Equatable {
  const ProgressBarEvent();
}

class FetchProgressBar extends ProgressBarEvent {
  @override
  List<Object> get props => [];
}
