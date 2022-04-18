part of 'grades_bloc.dart';

@immutable
abstract class GradesState extends Equatable {
  const GradesState();

  @override
  List<Object> get props => [];
}

class GradesInitial extends GradesState {}

class GradesLoading extends GradesState {}

class GradesLoaded extends GradesState {
  final List<Grade> grades;

  const GradesLoaded({
    @required this.grades,
  }) : assert(grades != null);

  GradesLoaded copyWith({
    List<Grade> grades,
  }) {
    return GradesLoaded(
      grades: grades ?? this.grades,
    );
  }

  @override
  List<Object> get props => [grades];

  @override
  String toString() => 'GradesLoaded { messages: ${grades.length},}';
}

class GradesError extends GradesState {}
