import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/coomon/dao/DaoResult.dart';
import 'package:queen/coomon/local/LocalStorage.dart';
import 'package:queen/coomon/net/Address.dart';
import 'package:queen/coomon/net/Api.dart';
import 'package:queen/models/userInfo.dart';

class UserInfoDao {
  ///獲取本地登入用戶信息
  static getUserInfoLocal() async {
    var userText = await LocalStorage.get(Config.userInfo);
    if (userText != null) {
      var userMap = json.decode(userText);
      UserInfo user = UserInfo.fromJson(userMap);
      return DataResult(user, true);
    } else {
      return DataResult(null, false);
    }
  }

  ///第三方登入
  static thirdLogin({required Map<String, dynamic> params}) async {
    String loginType = '';
    if (Platform.isAndroid) {
      loginType = 'google';
    } else {
      loginType = 'apple';
    }
    params["login_type"] = loginType;
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.thirdLogin(), params, header, Options(method: "post"));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("newsList resp =>  ${res.data}");
      }
    }
  }

  ///facebook login
  static facebookLogin({required Map<String, dynamic> params}) async {
    params["login_type"] = "facebook";
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.thirdLogin(), params, header, Options(method: "post"));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("newsList resp =>  ${res.data}");
      }
    }
  }

  ///zalo login
  static zalokLogin({required Map<String, dynamic> params}) async {
    params["login_type"] = "zalo";
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.thirdLogin(), params, header, Options(method: "post"));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("newsList resp =>  ${res.data}");
      }
    }
  }

  ///手機登入
  static mobileLogin({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.mobileLogin(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("newsList resp =>  ${res.data}");
      }
      if (res.data['ret'] == 200) {
        Map<String, dynamic> dataMap = res.data["data"];
        List<dynamic> infos = dataMap["info"];
        if (infos.isNotEmpty) {
          UserInfo userInfo = UserInfo.fromJson(infos[0]);
          await LocalStorage.save(Config.userPwd, params["user_pass"]);
          await LocalStorage.save(Config.userMobile, params["user_login"]);
          await LocalStorage.save(
              Config.userInfo, json.encode(userInfo.toJson()));
          mainDataArray = infos[0];
          return DataResult(mainDataArray, true);
        }
        return DataResult(mainDataArray, false);
      }
    }
  }

  ///取得註冊驗證碼
  static getCapcha({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.getCapcha(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("getCapcha resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
      }
      return DataResult(mainDataArray, true);
    }
  }

  ///註冊
  static registMobile({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    String device = "";
    if (Platform.isAndroid) {
      device = "android";
    } else {
      device = "ios";
    }
    params["source"] = device;
    var res = await HttpManager.netFetch(
        Address.registMobile(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("registMobile resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
      }
      return DataResult(mainDataArray, true);
    }
  }

  ///取得忘記密碼驗證碼
  static getForgotCapcha({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.getForgotCapcha(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("getForgotCapcha resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
      }
      return DataResult(mainDataArray, true);
    }
  }

  ///註冊
  static findUserPassword({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};

    var res = await HttpManager.netFetch(
        Address.getUserFindPass(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("findUserPassword resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
      }
      return DataResult(mainDataArray, true);
    }
  }
}
