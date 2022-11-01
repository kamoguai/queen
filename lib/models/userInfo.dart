import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable(explicitToJson: true)
class UserInfo {
  @JsonKey(name: 'id')
  String id;
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
  @JsonKey(name: 'login_type')
  String loginType;
  @JsonKey(name: 'last_login_time')
  String? lastLoginTime;
  @JsonKey(name: 'jim_name')
  String jimName;
  @JsonKey(name: 'jim_pass')
  String jimPass;
  @JsonKey(name: 'tim_usersig')
  String timUsersig;
  @JsonKey(name: 'isreg')
  String isreg;
  @JsonKey(name: 'is_store')
  String isStore;
  @JsonKey(name: 'level')
  String level;
  @JsonKey(name: 'level_anchor')
  String levelAnchor;
  @JsonKey(name: 'token')
  String token;

  UserInfo(
      {required this.id,
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
      required this.loginType,
      this.lastLoginTime,
      required this.jimName,
      required this.jimPass,
      required this.timUsersig,
      required this.isreg,
      required this.isStore,
      required this.level,
      required this.levelAnchor,
      required this.token});

  factory UserInfo.fromJson(Map<String, dynamic> map) =>
      _$UserInfoFromJson(map);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
