import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// import 'package:educa_feedback/models/topic.dart';
import 'package:educa_feedback/models/progress_bar.dart';
import 'package:educa_feedback/repositories/progress_repository.dart';

part 'progress_bar_event.dart';
part 'progress_bar_state.dart';

class ProgressBarBloc extends Bloc<ProgressBarEvent, ProgressBarState> {
  final ProgressRepository progressRepository;

  ProgressBarBloc({@required this.progressRepository})
      : assert(progressRepository != null),
        super(ProgressBarInitial());

  @override
  Stream<ProgressBarState> mapEventToState(
    ProgressBarEvent event,
  ) async* {
    if (event is FetchProgressBar) {
      yield* _mapFetchProgressBarToState(event);
    }
  }

  Stream<ProgressBarState> _mapFetchProgressBarToState(FetchProgressBar event) async* {
    try {
      yield ProgressBarLoading();
      final result = await progressRepository.getProgressBarInfo();
      yield ProgressBarLoaded(courseProgress: result.courseProgress, myProgress: result.myProgress);
    } catch (e) {
      print('error in progress_bloc' + e);
      yield ProgressBarError();
    }
  }
}
