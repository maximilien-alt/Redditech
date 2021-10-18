import 'package:json_annotation/json_annotation.dart';

part 'ProfileInfos.g.dart';

@JsonSerializable()
class ProfileInfos {
  final String name;
  ProfileInfos(this.name);
  factory ProfileInfos.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfosFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfosToJson(this);
}
