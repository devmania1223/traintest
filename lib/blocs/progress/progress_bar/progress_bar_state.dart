part of 'progress_bar_bloc.dart';

@immutable
abstract class ProgressBarState extends Equatable {
  const ProgressBarState();

  @override
  List<Object> get props => [];
}

class ProgressBarInitial extends ProgressBarState {}

class ProgressBarLoading extends ProgressBarState {}

class ProgressBarLoaded extends ProgressBarState {
  final int courseProgress;
  final int myProgress;

  const ProgressBarLoaded({
    @required this.courseProgress,
    @required this.myProgress,
  }) : assert(courseProgress != null);

  ProgressBarLoaded copyWith({
    ProgressBar progressBar,
  }) {
    return ProgressBarLoaded(
      courseProgress: courseProgress ?? this.courseProgress,
      myProgress: myProgress ?? this.myProgress,
    );
  }

  @override
  List<Object> get props => [courseProgress, myProgress];

  @override
  String toString() => 'ProgressBarLoaded}';
}

class ProgressBarError extends ProgressBarState {}
