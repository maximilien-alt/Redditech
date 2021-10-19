// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProfileInfos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileInfos _$ProfileInfosFromJson(Map<String, dynamic> json) => ProfileInfos(
      json['name'] as String,
      json['subreddit'] as Map<String, dynamic>,
      json['total_karma'] as int,
      json['icon_img'] as String,
    );

Map<String, dynamic> _$ProfileInfosToJson(ProfileInfos instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subreddit': instance.subreddit,
      'total_karma': instance.total_karma,
      'icon_img': instance.icon_img,
    };
