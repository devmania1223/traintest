import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Grade {
  int id;
  String name;
  int mark;
  Grade({
    this.id,
    this.name,
    this.mark,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => _$GradeFromJson(json);

  Map<String, dynamic> toJson() => _$GradeToJson(this);

  Grade copyWith({
    int id,
    String name,
    int mark,
  }) {
    return Grade(
      id: id ?? this.id,
      name: name ?? this.name,
      mark: mark ?? this.mark,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Grade _$GradeFromJson(Map<String, dynamic> json) {
  return Grade(
    id: json['id'] as int,
    name: json['name'] as String,
    mark: json['mark'] as int,
  );
}

Map<String, dynamic> _$GradeToJson(Grade instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'mark': instance.mark,
};
