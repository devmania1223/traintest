import 'package:json_annotation/json_annotation.dart';
import 'package:educa_feedback/models/test.dart';

@JsonSerializable()
class Assessment {
  @JsonKey(name: 'data')
  List<Test> tests;

  Assessment({
    this.tests,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assessment _$AssessmentFromJson(Map<String, dynamic> json) {
  return Assessment(
    tests: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Test.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AssessmentToJson(Assessment instance) => <String, dynamic>{
      'data': instance.tests,
    };

