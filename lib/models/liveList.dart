import 'package:json_annotation/json_annotation.dart';
part 'liveList.g.dart';

@JsonSerializable(explicitToJson: true)
class LiveList {
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'matchID')
  String matchID;
  @JsonKey(name: 'channel')
  String channel;
  @JsonKey(name: 'moduleTitle')
  String moduleTitle;
  @JsonKey(name: 'streamerUID')
  String streamerUID;
  @JsonKey(name: 'homeC')
  String homeC;
  @JsonKey(name: 'awayC')
  String awayC;
  @JsonKey(name: 'thumbURL')
  String thumbURL;
  @JsonKey(name: 'time')
  String time;
  @JsonKey(name: 'nowPlaying')
  int nowPlaying;
  @JsonKey(name: 'streamerCountry')
  String streamerCountry;
  @JsonKey(name: 'streamerThumb')
  String streamerThumb;
  @JsonKey(name: 'liveCount')
  int liveCount;
  LiveList({
    required this.type,
    required this.matchID,
    required this.channel,
    required this.moduleTitle,
    required this.streamerUID,
    required this.homeC,
    required this.awayC,
    required this.thumbURL,
    required this.time,
    required this.nowPlaying,
    required this.streamerCountry,
    required this.streamerThumb,
    required this.liveCount,
  });
  factory LiveList.fromJson(Map<String, dynamic> map) =>
      _$LiveListFromJson(map);

  Map<String, dynamic> toJson() => _$LiveListToJson(this);
}
