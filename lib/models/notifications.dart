import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Notifications {
  int id;
  String title;
  String content;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  Notifications({
    this.id,
    this.title,
    this.content,
    this.createdAt,
  });
  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);
}

Notifications _$NotificationsFromJson(Map<String, dynamic> json) {
  return Notifications(
    id: json['id'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$NotificationsToJson(Notifications instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
    };
