import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'liveNews.g.dart';

@JsonSerializable(explicitToJson: true)
class LiveNews {
  @JsonKey(name: 'newsuid')
  String newsuid;
  @JsonKey(name: 'time')
  String time;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'newsContent')
  String newsContent;

  LiveNews({
    required this.newsuid,
    required this.time,
    required this.title,
    required this.newsContent,
  });
  factory LiveNews.fromJson(Map<String, dynamic> map) =>
      _$LiveNewsFromJson(map);

  Map<String, dynamic> toJson() => _$LiveNewsToJson(this);
}
