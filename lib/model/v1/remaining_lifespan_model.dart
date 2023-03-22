import 'package:json_annotation/json_annotation.dart';

part 'remaining_lifespan_model.g.dart';

@JsonSerializable()
class RemainingLifespanModel {
  RemainingLifespanModel(
      this.code,
      this.data,
      this.message,
      );

  int code;
  int? data;
  String message;

  factory RemainingLifespanModel.fromJson(Map<String, dynamic> json) =>
      _$RemainingLifespanModelFromJson(json);

  Map<String, dynamic> toJson() => _$RemainingLifespanModelToJson(this);
}
