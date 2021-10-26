import 'package:json_annotation/json_annotation.dart';

part 'SettingsInfos.g.dart';

@JsonSerializable()
class SettingsInfos {
  final bool over_18;
  final bool video_autoplay;
  final bool show_stylesheets;
  final bool show_trending;
  final bool show_twitter;
  final bool store_visits;

  SettingsInfos(this.over_18, this.video_autoplay, this.show_stylesheets,
      this.show_trending, this.show_twitter, this.store_visits);
  factory SettingsInfos.fromJson(Map<String, dynamic> json) =>
      _$SettingsInfosFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsInfosToJson(this);
}
