import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  int id;

  String name;
  String photo;

  @JsonKey(nullable: true)
  String email;

  @JsonKey(name: 'created_at')
  DateTime createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.photo,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}


// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String,
    email: json['email'] as String,
    photo: json['photo'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'email': instance.email,
      'created_at': instance.createdAt?.toIso8601String(),
    };
