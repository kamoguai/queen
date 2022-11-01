import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/coomon/dao/DaoResult.dart';
import 'package:queen/coomon/net/Address.dart';
import 'package:queen/coomon/net/Api.dart';

class HomePageDao {
  ///取的live列表
  static productList({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataList = [];
    Map<String, dynamic> header = {
      'Accept': 'application/x-www-form-urlencoded',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var res = await HttpManager.netFetch(
        Address.getLiveList(), params, header, Options(method: "post"));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("productList resp =>  ${res.data}");
      }
      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];

        return DataResult(mainDataArray, true);
      }
    }
  }

  ///取得live新聞
  static newsList({required Map<String, dynamic> params}) async {
    Map<String, dynamic> mainDataArray = {};
    List<dynamic> dataList = [];
    Map<String, dynamic> header = {
      'Accept': 'application/x-www-form-urlencoded',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var res = await HttpManager.netFetch(
        Address.getLiveNews(), params, header, Options(method: "post"));
    if (res != null && res.result) {
      if (Config.debug) {
        debugPrint("newsList resp =>  ${res.data}");
      }

      if (res.data["ret"] == 200) {
        mainDataArray = res.data["data"];

        return DataResult(mainDataArray, true);
      }
    }
  }
}
