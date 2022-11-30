import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:live_flutter_plugin/v2_tx_live_def.dart';
import 'package:live_flutter_plugin/v2_tx_live_premier.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/pages/push/live_camera_push.dart';
import 'package:queen/producer/beauty_data_manager.dart';
import 'package:queen/widgets/progress_dialog.dart';
import 'package:tencent_effect_flutter/api/tencent_effect_api.dart';
import 'package:tencent_effect_flutter/utils/Logs.dart';

class RecordVideoPage extends StatefulWidget {
  const RecordVideoPage({super.key});

  @override
  State<RecordVideoPage> createState() => _RecordVideoPageState();
}

class _RecordVideoPageState extends State<RecordVideoPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  bool _isInitResource = false;

  /// 直播流id
  String _streamId = '123456';

  /// 当前音频质量
  V2TXLiveAudioQuality _audioQuality =
      V2TXLiveAudioQuality.v2TXLiveAudioQualityDefault;

  final TapGestureRecognizer _tap = TapGestureRecognizer();

  final _streamIdFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return SafeArea(
        child: Container(
      color: Colors.black,
      child: Stack(children: [
        Positioned(
            left: _deviceWidth * 0.05,
            top: _deviceHeight * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/开始观看直播/开播预览图片/live_close.png'),
            )),
        Positioned(
            right: _deviceWidth * 0.05,
            top: _deviceHeight * 0.05,
            child: GestureDetector(
              onTap: () async {
                startLive(context, V2TXLiveMode.v2TXLiveModeRTMP);
              },
              child: Image.asset(
                  'assets/images/开始观看直播/开播预览图片/pre_uploadThumb.png'),
            )),
      ]),
    ));
  }

  _initData() async {
    _onPressed(context);
    V2TXLivePremier.setLicence(
        Config.tencentLiveLicenceUrl, Config.tencentLiveLicenceKey);
  }

  void _initResouce(InitXmagicCallBack callBack) async {
    if (_isInitResource) {
      callBack.call(true);
      return;
    }
    String dir = await BeautyDataManager.getInstance().getResDir();
    TXLog.printlog('文件路径为：$dir');
    TencentEffectApi.getApi()?.initXmagic(dir, (reslut) {
      _isInitResource = reslut;
      callBack.call(reslut);
      if (!reslut) {
        Fluttertoast.showToast(msg: "初始化资源失败");
      }
    });
  }

  void _onPressed(BuildContext context) {
    // _showDialog(context);
    _initResouce((reslut) {
      if (reslut) {
        TencentEffectApi.getApi()?.setLicense(
            Config.telicenceXmagicKey, Config.telicenceXmagicLicence,
            (errorCode, msg) {
          // _dismissDialog(context);
          TXLog.printlog(
              'setLicense result : errorCode =$errorCode ,msg = $msg');
          if (errorCode == 0) {}
        });
      }
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const ProgressDialog();
        });
  }

  void _dismissDialog(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  startLive(BuildContext context, V2TXLiveMode liveMode) {
    if (_streamId == "") {
      return;
    }

    startCameraLive(context, liveMode);
  }

  /// 摄像头推流
  startCameraLive(BuildContext context, V2TXLiveMode liveMode) {
    if (_streamId == "") {
      return;
    }
    LiveCameraPushPage page = LiveCameraPushPage(
        audioQuality: _audioQuality, streamId: _streamId, liveMode: liveMode);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
