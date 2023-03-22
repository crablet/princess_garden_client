import 'package:json_annotation/json_annotation.dart';

part 'submit_message_model.g.dart';

@JsonSerializable()
class SubmitMessageModel {
  SubmitMessageModel(
    this.code,
    this.data,
    this.message,
  );

  int code;
  int? data;
  String message;

  factory SubmitMessageModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitMessageModelToJson(this);
}
