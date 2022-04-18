import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Topic {
  int id;
  String name;
  int mark;
  Topic({
    this.id,
    this.name,
    this.mark,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);

  Topic copyWith({
    int id,
    String name,
    int mark,
  }) {
    return Topic(
      id: id ?? this.id,
      name: name ?? this.name,
      mark: mark ?? this.mark,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return Topic(
    id: json['id'] as int,
    name: json['name'] as String,
    mark: json['mark'] as int,
  );
}

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'mark': instance.mark,
};
