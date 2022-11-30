import 'package:json_annotation/json_annotation.dart';
part 'liveVideoUrl.g.dart';

@JsonSerializable(explicitToJson: true)
class LiveVideoUrl {
  @JsonKey(name: 'h5link')
  String h5link;
  @JsonKey(name: 'streamerURL')
  String streamerURL;

  LiveVideoUrl({required this.h5link, required this.streamerURL});

  factory LiveVideoUrl.fromJson(Map<String, dynamic> map) =>
      _$LiveVideoUrlFromJson(map);

  Map<String, dynamic> toJson() => _$LiveVideoUrlToJson(this);
}
