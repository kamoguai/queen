import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:queen/producer/beauty_property_producer.dart';
import 'package:queen/producer/beauty_property_producer_android.dart';
import 'package:queen/producer/beauty_property_producer_ios.dart';
import 'package:tencent_effect_flutter/model/xmagic_property.dart';

class BeautyDataManager {
  static final BeautyDataManager _pannelDataManager =
      BeautyDataManager._internal();

  BeautyDataManager._internal();

  final BeautyPropertyProducer _beautyPropertyProducer = Platform.isAndroid
      ? BeautyPropertyProducerAndroid()
      : BeautyPropertyProducerIOS();

  static BeautyDataManager getInstance() {
    return _pannelDataManager;
  }

  ///获取资源存储路径
  Future<String> getResDir() async {
    String dir = await _beautyPropertyProducer.getResPath();
    return dir;
  }

  ///获取美颜面板的所有数据
  Future<Map<String, List<XmagicUIProperty>>?> getAllPannelData(
    BuildContext context,
  ) async {
    Map<String, List<XmagicUIProperty>>? data;
    data = await _beautyPropertyProducer.getAllDatas(context);
    return data;
  }

  ///滤镜资源名对应的面板显示名称
  static Map<String, String> lutDataMap = {
    "n_baixi.png": "filter_baizhi",
    "n_ziran.png": "filter_ziran",
    "moren_lf.png": "filter_chulian",
    "xindong_lf.png": "filter_xindong",
    "dongjing_lf.png": "filter_dongjing",
  };

  ///工具方法，用于将动效。美妆。分割的字符串解析为map
  static Map<String, String> getMaterialDataByStr(String? str) {
    Map<String, String> propertyNameConverter = {};
    List<String> pairs = str!.split(",");
    for (int i = 0; i < pairs.length; i++) {
      String pair = pairs[i];
      List<String> keyValue = pair.split(":");
      propertyNameConverter[keyValue[0].trim()] = keyValue[1].trim();
    }
    return propertyNameConverter;
  }
}
