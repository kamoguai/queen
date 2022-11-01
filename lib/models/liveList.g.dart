// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveList _$LiveListFromJson(Map<String, dynamic> json) => LiveList(
      type: json['type'] as String,
      matchID: json['matchID'] as String,
      channel: json['channel'] as String,
      moduleTitle: json['moduleTitle'] as String,
      streamerUID: json['streamerUID'] as String,
      homeC: json['homeC'] as String,
      awayC: json['awayC'] as String,
      thumbURL: json['thumbURL'] as String,
      time: json['time'] as String,
      nowPlaying: json['nowPlaying'] as int,
      streamerCountry: json['streamerCountry'] as String,
      streamerThumb: json['streamerThumb'] as String,
      liveCount: json['liveCount'] as int,
    );

Map<String, dynamic> _$LiveListToJson(LiveList instance) => <String, dynamic>{
      'type': instance.type,
      'matchID': instance.matchID,
      'channel': instance.channel,
      'moduleTitle': instance.moduleTitle,
      'streamerUID': instance.streamerUID,
      'homeC': instance.homeC,
      'awayC': instance.awayC,
      'thumbURL': instance.thumbURL,
      'time': instance.time,
      'nowPlaying': instance.nowPlaying,
      'streamerCountry': instance.streamerCountry,
      'streamerThumb': instance.streamerThumb,
      'liveCount': instance.liveCount,
    };
