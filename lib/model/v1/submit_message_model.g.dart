// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitMessageModel _$SubmitMessageModelFromJson(Map<String, dynamic> json) =>
    SubmitMessageModel(
      json['code'] as int,
      json['data'] as int?,
      json['message'] as String,
    );

Map<String, dynamic> _$SubmitMessageModelToJson(SubmitMessageModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };
