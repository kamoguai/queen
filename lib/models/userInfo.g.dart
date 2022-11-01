// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      id: json['id'] as String,
      userNicename: json['user_nicename'] as String,
      avatar: json['avatar'] as String,
      avatarThumb: json['avatar_thumb'] as String,
      sex: json['sex'] as String,
      signature: json['signature'] as String,
      coin: json['coin'] as String,
      consumption: json['consumption'] as String,
      votestotal: json['votestotal'] as String,
      province: json['province'] as String,
      city: json['city'] as String,
      birthday: json['birthday'] as String,
      loginType: json['login_type'] as String,
      lastLoginTime: json['last_login_time'] as String?,
      jimName: json['jim_name'] as String,
      jimPass: json['jim_pass'] as String,
      timUsersig: json['tim_usersig'] as String,
      isreg: json['isreg'] as String,
      isStore: json['is_store'] as String,
      level: json['level'] as String,
      levelAnchor: json['level_anchor'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'id': instance.id,
      'user_nicename': instance.userNicename,
      'avatar': instance.avatar,
      'avatar_thumb': instance.avatarThumb,
      'sex': instance.sex,
      'signature': instance.signature,
      'coin': instance.coin,
      'consumption': instance.consumption,
      'votestotal': instance.votestotal,
      'province': instance.province,
      'city': instance.city,
      'birthday': instance.birthday,
      'login_type': instance.loginType,
      'last_login_time': instance.lastLoginTime,
      'jim_name': instance.jimName,
      'jim_pass': instance.jimPass,
      'tim_usersig': instance.timUsersig,
      'isreg': instance.isreg,
      'is_store': instance.isStore,
      'level': instance.level,
      'level_anchor': instance.levelAnchor,
      'token': instance.token,
    };
