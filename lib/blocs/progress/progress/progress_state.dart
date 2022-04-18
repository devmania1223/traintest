part of 'progress_bloc.dart';

@immutable
abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final List<Topic> topics;
  const ProgressLoaded({
    @required this.topics,
  }) : assert(topics != null);

  ProgressLoaded copyWith({
    List<Topic> topics,
  }) {
    return ProgressLoaded(
      topics: topics ?? this.topics,
    );
  }

  @override
  List<Object> get props => [topics];

  @override
  String toString() => 'ProgressLoaded { messages: ${topics.length},}';
}

class ProgressError extends ProgressState {}
