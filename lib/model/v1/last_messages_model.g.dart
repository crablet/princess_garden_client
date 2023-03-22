// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_messages_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastMessagesModel _$LastMessagesModelFromJson(Map<String, dynamic> json) =>
    LastMessagesModel(
      json['code'] as int,
      (json['data'] as List<dynamic>?)
          ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['message'] as String,
    );

Map<String, dynamic> _$LastMessagesModelToJson(LastMessagesModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      json['id'] as int,
      json['author'] as String,
      json['content'] as String,
      json['time'] as String,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'content': instance.content,
      'time': instance.time,
    };
