// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SettingsInfos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingsInfos _$SettingsInfosFromJson(Map<String, dynamic> json) =>
    SettingsInfos(
      json['over_18'] as bool,
      json['video_autoplay'] as bool,
      json['show_stylesheets'] as bool,
      json['show_trending'] as bool,
      json['show_twitter'] as bool,
      json['store_visits'] as bool,
    );

Map<String, dynamic> _$SettingsInfosToJson(SettingsInfos instance) =>
    <String, dynamic>{
      'over_18': instance.over_18,
      'video_autoplay': instance.video_autoplay,
      'show_stylesheets': instance.show_stylesheets,
      'show_trending': instance.show_trending,
      'show_twitter': instance.show_twitter,
      'store_visits': instance.store_visits,
    };
