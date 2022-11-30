import 'package:json_annotation/json_annotation.dart';

part 'liveUser.g.dart';

@JsonSerializable(explicitToJson: true)
class LiveUser {
  @JsonKey(name: 'isdnd')
  String isdnd;
  @JsonKey(name: 'fans')
  String fans;
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'country')
  String country;
  @JsonKey(name: 'level')
  String level;
  @JsonKey(name: 'bg_img')
  String bgImg;
  @JsonKey(name: 'avatar_thumb')
  String avatarThumb;
  @JsonKey(name: 'votes')
  String votes;
  @JsonKey(name: 'live_status')
  int liveStatus;
  @JsonKey(name: 'single_answer')
  String singleAnswer;
  @JsonKey(name: 'votestotal')
  String votestotal;
  @JsonKey(name: 'coin')
  String coin;
  @JsonKey(name: 'level_anchor')
  String levelAnchor;
  @JsonKey(name: 'sex')
  String sex;
  @JsonKey(name: 'user_login')
  String userLogin;
  @JsonKey(name: 'video_count')
  String videoCount;
  @JsonKey(name: 'birthday')
  String birthday;
  @JsonKey(name: 'single_switch')
  String singleSwitch;
  @JsonKey(name: 'city')
  String city;
  @JsonKey(name: 'avatar')
  String avatar;
  @JsonKey(name: 'last_conn')
  String lastConn;
  @JsonKey(name: 'lives')
  int lives;
  @JsonKey(name: 'user_nicename')
  String userNicename;
  @JsonKey(name: 'consumption')
  String consumption;
  @JsonKey(name: 'province')
  String province;
  @JsonKey(name: 'single_charge')
  String singleCharge;
  @JsonKey(name: 'follows')
  String follows;
  @JsonKey(name: 'user_auth')
  int userAuth;
  @JsonKey(name: 'signature')
  String signature;
  @JsonKey(name: 'constellation')
  String constellation;
  @JsonKey(name: 'single_img')
  String singleImg;
  @JsonKey(name: 'single_refuse')
  String singleRefuse;
  @JsonKey(name: 'live_auth')
  String liveAuth;
  @JsonKey(name: 'auth_video')
  String authVideo;
  @JsonKey(name: 'money')
  int money;
  @JsonKey(name: 'vip')
  Map<String, dynamic> vip;
  @JsonKey(name: 'liang')
  Map<String, dynamic> liang;

  LiveUser(
      {required this.isdnd,
      required this.fans,
      required this.id,
      required this.country,
      required this.level,
      required this.bgImg,
      required this.avatarThumb,
      required this.votes,
      required this.liveStatus,
      required this.singleAnswer,
      required this.votestotal,
      required this.coin,
      required this.levelAnchor,
      required this.sex,
      required this.userLogin,
      required this.videoCount,
      required this.birthday,
      required this.singleSwitch,
      required this.city,
      required this.avatar,
      required this.lastConn,
      required this.lives,
      required this.userNicename,
      required this.consumption,
      required this.province,
      required this.singleCharge,
      required this.follows,
      required this.userAuth,
      required this.authVideo,
      required this.constellation,
      required this.liang,
      required this.liveAuth,
      required this.money,
      required this.signature,
      required this.singleImg,
      required this.singleRefuse,
      required this.vip});
  factory LiveUser.fromJson(Map<String, dynamic> map) =>
      _$LiveUserFromJson(map);

  Map<String, dynamic> toJson() => _$LiveUserToJson(this);
}
