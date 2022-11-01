// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liveNews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LiveNews _$LiveNewsFromJson(Map<String, dynamic> json) => LiveNews(
      newsuid: json['newsuid'] as String,
      time: json['time'] as String,
      title: json['title'] as String,
      newsContent: json['newsContent'] as String,
    );

Map<String, dynamic> _$LiveNewsToJson(LiveNews instance) => <String, dynamic>{
      'newsuid': instance.newsuid,
      'time': instance.time,
      'title': instance.title,
      'newsContent': instance.newsContent,
    };
