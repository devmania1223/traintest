import 'package:json_annotation/json_annotation.dart';
import 'package:educa_feedback/models/problem.dart';

@JsonSerializable()
class Exam {
  @JsonKey(name: 'data')
  List<Problem> problems;

  Exam({
    this.problems,
  });

  factory Exam.fromJson(Map<String, dynamic> json) =>
      _$ExamFromJson(json);

  Map<String, dynamic> toJson() => _$ExamToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exam _$ExamFromJson(Map<String, dynamic> json) {
  return Exam(
    problems: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Problem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
      'data': instance.problems,
    };
