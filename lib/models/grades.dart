import 'package:json_annotation/json_annotation.dart';
import 'package:educa_feedback/models/grade.dart';

@JsonSerializable()
class Grades {
  @JsonKey(name: 'data')
  List<Grade> grades;

  Grades({
    this.grades,
  });

  factory Grades.fromJson(Map<String, dynamic> json) =>
      _$GradesFromJson(json);

  Map<String, dynamic> toJson() => _$GradesToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grades _$GradesFromJson(Map<String, dynamic> json) {
  return Grades(
    grades: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Grade.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GradesToJson(Grades instance) => <String, dynamic>{
      'data': instance.grades,
    };
