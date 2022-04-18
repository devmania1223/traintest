import 'package:json_annotation/json_annotation.dart';
import 'package:educa_feedback/models/test.dart';

@JsonSerializable()
class Exercise {
  @JsonKey(name: 'data')
  List<Test> tests;

  Exercise({
    this.tests,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return Exercise(
    tests: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Test.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'data': instance.tests,
    };
