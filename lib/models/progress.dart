import 'package:json_annotation/json_annotation.dart';
import 'package:educa_feedback/models/topic.dart';

@JsonSerializable()
class Progress {
  @JsonKey(name: 'data')
  List<Topic> topics;

  Progress({
    this.topics,
  });

  factory Progress.fromJson(Map<String, dynamic> json) =>
      _$ProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressToJson(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Progress _$ProgressFromJson(Map<String, dynamic> json) {
  return Progress(
    topics: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Topic.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProgressToJson(Progress instance) => <String, dynamic>{
      'data': instance.topics,
    };
