import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/models/topic.dart';
import 'package:educa_feedback/repositories/progress_repository.dart';

part 'progress_event.dart';
part 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final ProgressRepository progressRepository;

  ProgressBloc({@required this.progressRepository})
      : assert(progressRepository != null),
        super(ProgressInitial());

  @override
  Stream<ProgressState> mapEventToState(
    ProgressEvent event,
  ) async* {
    if (event is FetchProgress) {
      yield* _mapFetchProgressToState(event);
    }
  }

  Stream<ProgressState> _mapFetchProgressToState(FetchProgress event) async* {
    try {
      yield ProgressLoading();
      final result = await progressRepository.getProgressInfo();
      yield ProgressLoaded(topics: result.topics);
    } catch (e) {
      print('error in progress_bloc' + e);
      yield ProgressError();
    }
  }
}
