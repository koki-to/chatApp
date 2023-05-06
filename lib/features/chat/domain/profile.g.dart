// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Profile _$$_ProfileFromJson(Map<String, dynamic> json) => _$_Profile(
      id: json['id'] as String,
      username: json['username'] as String,
      createdAt:
          const DateTimeConverter().fromJson(json['created_at'] as String),
    );

Map<String, dynamic> _$$_ProfileToJson(_$_Profile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
    };
