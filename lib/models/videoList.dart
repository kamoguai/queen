import 'package:json_annotation/json_annotation.dart';
part 'videoList.g.dart';

@JsonSerializable(explicitToJson: true)
class VideoList {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'uid')
  String uid;
  @JsonKey(name: 'type_id')
  String typeId;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'thumb')
  String thumb;
  @JsonKey(name: 'thumb_s')
  String thumbS;
  @JsonKey(name: 'href')
  String href;
  @JsonKey(name: 'likes')
  String likes;
  @JsonKey(name: 'views')
  String views;
  @JsonKey(name: 'comments')
  String comments;
  @JsonKey(name: 'steps')
  String steps;
  @JsonKey(name: 'shares')
  String shares;
  @JsonKey(name: 'addtime')
  String addtime;
  @JsonKey(name: 'lat')
  String lat;
  @JsonKey(name: 'lng')
  String lng;
  @JsonKey(name: 'city')
  String city;
  @JsonKey(name: 'isdel')
  String isdel;
  @JsonKey(name: 'status')
  String status;
  @JsonKey(name: 'music_id')
  String musicId;
  @JsonKey(name: 'xiajia_reason')
  String? xiajiaReason;
  @JsonKey(name: 'show_val')
  String showVal;
  @JsonKey(name: 'nopass_time')
  String nopassTime;
  @JsonKey(name: 'watch_ok')
  String watchOk;
  @JsonKey(name: 'is_ad')
  String isAd;
  @JsonKey(name: 'typad_endtimee')
  String? adEndtime;
  @JsonKey(name: 'ad_url')
  String? adUrl;
  @JsonKey(name: 'orderno')
  String orderno;
  @JsonKey(name: 'is_shopping')
  String isShopping;
  @JsonKey(name: 'is_hot')
  String isHot;
  @JsonKey(name: 'userinfo')
  VideoUserInfo videoUserInfo;
  @JsonKey(name: 'datetime')
  String datetime;
  @JsonKey(name: 'islike')
  String islike;
  @JsonKey(name: 'isstep')
  String isstep;
  @JsonKey(name: 'isattent')
  String isattent;
  int tag;

  VideoList(
      {required this.id,
      required this.uid,
      required this.typeId,
      required this.title,
      required this.thumb,
      required this.thumbS,
      required this.href,
      required this.likes,
      required this.views,
      required this.comments,
      required this.steps,
      required this.shares,
      required this.addtime,
      required this.lat,
      required this.lng,
      required this.city,
      required this.isdel,
      required this.status,
      required this.musicId,
      this.xiajiaReason,
      required this.showVal,
      required this.nopassTime,
      required this.watchOk,
      required this.isAd,
      this.adEndtime,
      this.adUrl,
      required this.orderno,
      required this.isShopping,
      required this.isHot,
      required this.videoUserInfo,
      required this.datetime,
      required this.islike,
      required this.isstep,
      required this.isattent,
      required this.tag});

  factory VideoList.fromJson(Map<String, dynamic> map, t) =>
      _$VideoListFromJson(map, t);

  Map<String, dynamic> toJson() => _$VideoListToJson(this);
}

@JsonSerializable(explicitToJson: true)
class VideoUserInfo {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'user_login')
  String userLogin;
  @JsonKey(name: 'user_nicename')
  String userNicename;
  @JsonKey(name: 'avatar')
  String avatar;
  @JsonKey(name: 'avatar_thumb')
  String avatarThumb;
  @JsonKey(name: 'sex')
  String sex;
  @JsonKey(name: 'signature')
  String signature;
  @JsonKey(name: 'coin')
  String coin;
  @JsonKey(name: 'consumption')
  String consumption;
  @JsonKey(name: 'votestotal')
  String votestotal;
  @JsonKey(name: 'province')
  String province;
  @JsonKey(name: 'city')
  String city;
  @JsonKey(name: 'birthday')
  String birthday;
  @JsonKey(name: 'user_status')
  String userStatus;
  @JsonKey(name: 'issuper')
  String issuper;
  @JsonKey(name: 'bg_img')
  String bgImg;
  @JsonKey(name: 'single_switch')
  String singleSwitch;
  @JsonKey(name: 'constellation')
  String constellation;
  @JsonKey(name: 'single_refuse')
  String singleRefuse;
  @JsonKey(name: 'single_answer')
  String singleAnswer;
  @JsonKey(name: 'single_charge')
  String singleCharge;
  @JsonKey(name: 'last_conn')
  String lastConn;
  @JsonKey(name: 'live_status')
  dynamic liveStatus;
  @JsonKey(name: 'level')
  String level;
  @JsonKey(name: 'level_anchor')
  String levelAnchor;

  VideoUserInfo(
      {required this.id,
      required this.userLogin,
      required this.userNicename,
      required this.avatar,
      required this.avatarThumb,
      required this.sex,
      required this.signature,
      required this.coin,
      required this.consumption,
      required this.votestotal,
      required this.province,
      required this.city,
      required this.birthday,
      required this.userStatus,
      required this.issuper,
      required this.bgImg,
      required this.singleSwitch,
      required this.constellation,
      required this.singleRefuse,
      required this.singleAnswer,
      required this.singleCharge,
      required this.lastConn,
      required this.liveStatus,
      required this.level,
      required this.levelAnchor});

  factory VideoUserInfo.fromJson(Map<String, dynamic> map) =>
      _$VideoUserInfoFromJson(map);

  Map<String, dynamic> toJson() => _$VideoUserInfoToJson(this);
}
