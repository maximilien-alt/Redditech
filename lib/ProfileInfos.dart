import 'package:json_annotation/json_annotation.dart';

part 'ProfileInfos.g.dart';

@JsonSerializable()
class ProfileInfos {
  final String name;
  final Map<String, dynamic> subreddit;
  final int total_karma;
  final String icon_img;
  ProfileInfos(this.name, this.subreddit, this.total_karma, this.icon_img);
  factory ProfileInfos.fromJson(Map<String, dynamic> json) =>
      _$ProfileInfosFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileInfosToJson(this);
}
