import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Test {
  int id;

  @JsonKey(name: 'name')
  String name;
  int cateId;
  int sectionId;
  String cateName;
  String sectionName;
  String lastTime;
  int mark;
  Test({
    this.id,
    this.name,
    this.cateId,
    this.sectionId,
    this.cateName,
    this.sectionName,
    this.lastTime,
    this.mark,
  });

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);

  Map<String, dynamic> toJson() => _$TestToJson(this);

  Test copyWith({
    int id,
    String name,
    int cateId,
    int sectionId,
    String cateName,
    String sectionName,
    String lastTime,
    int mark,
  }) {
    return Test(
      id: id ?? this.id,
      name: name ?? this.name,
      cateId: cateId ?? this.cateId,
      sectionId: sectionId ?? this.sectionId,
      cateName: cateName ?? this.cateName,
      sectionName: sectionName ?? this.sectionName,
      lastTime: lastTime ?? this.lastTime,
      mark: mark ?? this.mark,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) {
  return Test(
    id: json['id'] as int,
    name: json['name'] as String,
    cateId: json['cate_id'] as int,
    sectionId: json['section_id'] as int,
    cateName: json['cate_name'] as String,
    sectionName: json['section_name'] as String,
    lastTime: json['last_time'] as String,
    mark: json['mark'] as int,
  );
}

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'cate_id': instance.cateId,
  'section_id': instance.sectionId,
  'cate_name': instance.cateName,
  'section_name': instance.sectionName,
  'last_time': instance.lastTime,
  'mark': instance.mark,
};
