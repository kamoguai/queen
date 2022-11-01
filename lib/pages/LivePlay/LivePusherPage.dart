import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:live_flutter_plugin/v2_tx_live_def.dart';
import 'package:live_flutter_plugin/v2_tx_live_premier.dart';
import 'package:live_flutter_plugin/v2_tx_live_pusher.dart';
import 'package:live_flutter_plugin/v2_tx_live_pusher_observer.dart';
import 'package:live_flutter_plugin/widget/v2_tx_live_video_widget.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class LivePusherPage extends StatefulWidget {
  const LivePusherPage({super.key});

  @override
  State<LivePusherPage> createState() => _LivePusherPageState();
}

class _LivePusherPageState extends State<LivePusherPage> {
  final LICENSEURL =
      "https://license.vod2.myqcloud.com/license/v2/1309042385_1/v_cube.license";
  final LICENSURLKEY = "fd6ca0306a6489dfb45fbd5213c8c7d4";

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Container();
  }

  setupLicense() {
    V2TXLivePremier.setLicence(LICENSEURL, LICENSURLKEY);
  }
}

enum LiveStartPushType {
  /// 摄像头推流
  camera,

  /// 屏幕分享
  screen,
}
