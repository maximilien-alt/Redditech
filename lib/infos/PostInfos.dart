import 'package:json_annotation/json_annotation.dart';

part 'PostInfos.g.dart';

@JsonSerializable()
class PostInfos {
  final Map<String, dynamic> data;
  PostInfos(this.data);
  factory PostInfos.fromJson(Map<String, dynamic> json) =>
      _$PostInfosFromJson(json);
  Map<String, dynamic> toJson() => _$PostInfosToJson(this);
}
