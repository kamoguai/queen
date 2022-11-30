import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/coomon/dao/DaoResult.dart';
import 'package:queen/coomon/local/LocalStorage.dart';
import 'package:queen/coomon/net/Address.dart';
import 'package:queen/coomon/net/Api.dart';
import 'package:queen/models/liveUser.dart';

class LiveDao {
  ///創建主播房
  static createRoom({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.createRoom(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("createRoom resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
      }
      return DataResult(mainDataArray, true);
    }
  }

  ///結束主播房
  static stopRoom({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.stopRoom(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("stopRoom resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
      }
      return DataResult(mainDataArray, true);
    }
  }

  ///直播結束，收益、觀看人數、時常信息
  static getLiveEndInfo({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.stopRoom(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("getLiveEndInfo resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
      }
      return DataResult(mainDataArray, true);
    }
  }

  ///live user info
  static getAnchor({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    Map<String, dynamic> header = {};
    var res = await HttpManager.netFetch(
        Address.getAnchor(),
        params,
        header,
        Options(
            method: "post", contentType: Headers.formUrlEncodedContentType));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("getAnchor resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];
        LiveUser liveUser = LiveUser.fromJson(mainDataArray['info'][0]);
        await LocalStorage.save(
            Config.liveUser, json.encode(liveUser.toJson()));
      }
      return DataResult(mainDataArray, true);
    }
  }

  ///獲取本地登入用戶信息
  static getLiveUserLocal() async {
    var userText = await LocalStorage.get(Config.liveUser);
    if (userText != null) {
      var userMap = json.decode(userText);
      LiveUser user = LiveUser.fromJson(userMap);
      return DataResult(user, true);
    } else {
      return DataResult(null, false);
    }
  }
}
