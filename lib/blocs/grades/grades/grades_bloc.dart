import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:educa_feedback/models/grade.dart';
import 'package:educa_feedback/repositories/grades_repository.dart';

part 'grades_event.dart';
part 'grades_state.dart';

class GradesBloc extends Bloc<GradesEvent, GradesState> {
  final GradesRepository gradesRepository;

  GradesBloc({@required this.gradesRepository})
      : assert(gradesRepository != null),
        super(GradesInitial());

  @override
  Stream<GradesState> mapEventToState(
    GradesEvent event,
  ) async* {
    if (event is FetchGrades) {
      yield* _mapFetchGradesToState(event);
    }
  }

  Stream<GradesState> _mapFetchGradesToState(FetchGrades event) async* {
    try {
      yield GradesLoading();
      final result = await gradesRepository.getGradesInfo();
      yield GradesLoaded(grades: result.grades);
    } catch (e) {
      print('error in grades_bloc' + e);
      yield GradesError();
    }
  }
}
