part of 'grades_bloc.dart';

abstract class GradesEvent extends Equatable {
  const GradesEvent();
}

class FetchGrades extends GradesEvent {
  @override
  List<Object> get props => [];
}
