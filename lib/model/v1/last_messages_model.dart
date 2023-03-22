import 'package:json_annotation/json_annotation.dart';

part 'last_messages_model.g.dart';

@JsonSerializable()
class LastMessagesModel {
  LastMessagesModel(
      this.code,
      this.data,
      this.message,
      );

  int code;
  List<MessageModel>? data;
  String message;

  factory LastMessagesModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessagesModelToJson(this);
}

@JsonSerializable()
class MessageModel {
  MessageModel(this.id, this.author, this.content, this.time,);

  int id;
  String author;
  String content;
  String time;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
