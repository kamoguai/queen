import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:live_flutter_plugin/manager/tx_audio_effect_manager.dart';
import 'package:live_flutter_plugin/manager/tx_beauty_manager.dart';
import 'package:live_flutter_plugin/manager/tx_device_manager.dart';
import 'package:live_flutter_plugin/v2_tx_live_code.dart';
import 'package:live_flutter_plugin/v2_tx_live_def.dart';
import 'package:live_flutter_plugin/v2_tx_live_premier.dart';
import 'package:live_flutter_plugin/v2_tx_live_pusher.dart';
import 'package:live_flutter_plugin/widget/v2_tx_live_video_widget.dart';
import 'package:live_flutter_plugin/v2_tx_live_pusher_observer.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/coomon/dao/LiveDao.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/coomon/socket/socketClient.dart';
import 'package:queen/coomon/socket/socketMessageListener.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/models/liveChat.dart';
import 'package:queen/models/userInfo.dart';
import 'package:queen/producer/beauty_data_manager.dart';
import 'package:queen/widgets/custom_input_fields.dart';
import 'package:queen/widgets/pannel_view.dart';
import 'package:tencent_effect_flutter/api/tencent_effect_api.dart';
import 'package:tencent_effect_flutter/utils/Logs.dart';
import 'settings/live_beauty_setting.dart';
import 'settings/live_audio_setting.dart';
import 'package:image_cropper/image_cropper.dart';

/// 摄像头推流
class LiveCameraPushPage extends StatefulWidget {
  final V2TXLiveMode liveMode;
  final V2TXLiveAudioQuality audioQuality;
  final String streamId;

  const LiveCameraPushPage(
      {Key? key,
      required this.audioQuality,
      required this.streamId,
      required this.liveMode})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LiveCameraPushPageState();
  }
}

class _LiveCameraPushPageState extends State<LiveCameraPushPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  ///取得keyboard size
  late double _keyboardSize;

  /// 分辨率
  V2TXLiveVideoResolution _resolution =
      V2TXLiveVideoResolution.v2TXLiveVideoResolution1280x720;

  /// 旋转角度
  V2TXLiveRotation _liveRotation = V2TXLiveRotation.v2TXLiveRotation0;

  /// 摄像头
  V2TXLiveMirrorType _liveMirrorType =
      V2TXLiveMirrorType.v2TXLiveMirrorTypeAuto;

  bool _isEnableBeauty = false;

  /// 音频设置
  bool _microphoneEnable = true;
  TXDeviceManager? _txDeviceManager;
  TXBeautyManager? _txBeautyManager;
  TXAudioEffectManager? _txAudioManager;

  /// 美颜设置数据
  final LiveBeautySettings _beautySettings = LiveBeautySettings();

  /// 音频数据
  final LiveAudioSettings _audioSettings = LiveAudioSettings();
  int? _localViewId;
  V2TXLivePusher? _livePusher;
  bool? _isFrontCamera;

  TextEditingController _editCtrl = TextEditingController();

  ///頭像圖片選擇
  File? _image;

  ///美顏
  bool _isInitResource = false;
  bool _isOpenBeauty = true;

  ///使用者資訊
  late UserInfo userInfo;

  ///直播頻道id
  int _liveClassId = 1;

  ///房間類型
  int _liveType = 0;

  ///房間密碼、門票收非金額
  int _liveTypeVal = 0;

  ///是否開始直播推流
  bool isStartPusher = false;

  ///直播倒數計時
  int pushCountDown = 3;
  Timer? _timer;
  DateTime? _pushTime;

  ///直播地址
  String _pushAddress = "";
  String _pushStream = "";

  ///texteditcontroller key
  late GlobalKey<FormState> _messageFormState;
  late ScrollController _messagesListViewController;
  bool _isOpenMessageTextField = false;

  ////////   socket /////
  //是否是第一次连接成功socket
  bool _firstConnectSocket = false;
  SocketClient? _socketClient;

  @override
  void initState() {
    super.initState();
    initLive();
    initBeauty();
    initData();
  }

  @override
  void deactivate() {
    debugPrint("Live-Camera push deactivate");
    _livePusher?.removeListener(onPusherObserver);
    _livePusher?.stopMicrophone();
    _livePusher?.stopCamera();
    _livePusher?.stopPush();
    resetBeautySetting();
    _livePusher?.destroy();
    super.deactivate();
  }

  @override
  dispose() {
    debugPrint("Live-Camera push dispose");
    super.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _keyboardSize = MediaQuery.of(context).viewInsets.bottom;
    return MaterialApp(
      home: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: !_isStartPush ? pushBefore() : pushStart(),
        ),
      ),
    );
  }

  ///開始推流前
  List<Widget> pushBefore() {
    List<Widget> list = [];
    list = [
      renderWidget(),
      leavePushWidget(),
      Positioned(
        left: _deviceWidth * 0.05,
        top: _deviceHeight * 0.1,
        child: IconButton(
            iconSize: _deviceHeight * 0.05,
            icon: Icon(Icons.camera_alt_outlined, color: Colors.white),
            onPressed: () async {
              setState(() {
                if (_isFrontCamera!) {
                  _isFrontCamera = false;
                } else {
                  _isFrontCamera = true;
                }
                _txDeviceManager?.switchCamera(_isFrontCamera!);
              });
            }),
      ),
      Positioned(
          top: _deviceHeight * 0.25,
          child: Container(
            height: _deviceHeight * 0.3,
            width: _deviceWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: _deviceWidth * 0.02,
                      vertical: _deviceHeight * 0.02),
                  child: Row(children: [
                    GestureDetector(
                      child: _image == null
                          ? Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: _deviceHeight * 0.15,
                              width: _deviceHeight * 0.15,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: Colors.amber,
                                    size: _deviceHeight * 0.1,
                                  ),
                                  Text(
                                    '直播封面',
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize:
                                            MyScreen.minBigFontSize(context),
                                        decoration: TextDecoration.none),
                                  )
                                ],
                              )))
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover)),
                              height: _deviceHeight * 0.15,
                              width: _deviceHeight * 0.15,
                              // child: Image.file(
                              //   _image!,
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                      onTap: () {
                        _showImageActionSheet(context);
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('直播標題',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: MyScreen.minBigFontSize(context),
                                  decoration: TextDecoration.none)),
                          SizedBox(
                            width: _deviceWidth * 0.44,
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '給直播寫個標題吧',
                                  hintStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.6),
                                      fontSize:
                                          MyScreen.appBarFontSize(context))),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: MyScreen.appBarFontSize(context)),
                              controller: _editCtrl,
                              onChanged: (val) {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
                  child: Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.white,
                  ),
                )
              ]),
            ),
          )),
      Positioned(
        bottom: _deviceHeight * 0.18,
        left: _deviceWidth * 0.2,
        child: GestureDetector(
          child: Row(children: [
            Image.asset(
              'assets/images/开始观看直播/开播预览图片/pre_fitter.png',
              scale: 1.5,
            ),
            Text(
              '美顏',
              style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            )
          ]),
          onTap: () {
            _showModalBeautySheet(context);
          },
        ),
      ),
      Positioned(
          bottom: _deviceHeight * 0.1,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[200],
              minimumSize: Size(_deviceWidth * 0.7, _deviceHeight * 0.06),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: Text(
              '開始直播',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MyScreen.defaultTableCellFontSize(context)),
            ),
            onPressed: () {
              pushCounter();
            },
          ))
    ];
    return list;
  }

  ///開始推流畫面
  List<Widget> pushStart() {
    List<Widget> list = [];

    if (pushCountDown <= -1) {
      list = [
        renderWidget(),
        leavePushWidget(),
        Positioned(
            left: _deviceWidth * 0.02,
            top: _deviceHeight * 0.05,
            child: Container(
              width: _deviceWidth * 0.5,
              height: _deviceHeight * 0.1,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(55.0),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.pink[100],
                  child: CircleAvatar(
                    radius: 43,
                    backgroundImage: NetworkImage(userInfo.avatarThumb),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userInfo.userNicename,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MyScreen.minFontSize(context),
                          decoration: TextDecoration.none),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: _deviceWidth * 0.02,
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: MyScreen.minFontSize(context),
                              decoration: TextDecoration.none),
                        )
                      ],
                    )
                  ],
                )
              ]),
            )),
        Positioned(
            left: _deviceWidth * 0.02,
            top: _deviceHeight * 0.16,
            child: Container(
              width: _deviceWidth * 0.3,
              height: _deviceHeight * 0.05,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(55.0),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/MyProfile/ic_qcoin.png'),
                    Text(
                      '1220',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MyScreen.minFontSize(context),
                          decoration: TextDecoration.none),
                    )
                  ]),
            )),
        Positioned(
            left: _deviceWidth * 0.02,
            top: _deviceHeight * 0.22,
            child: Container(
              width: _deviceWidth * 0.25,
              height: _deviceHeight * 0.05,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(55.0),
              ),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.purpleAccent,
                ),
                Text(
                  DateFormat.Hms().format(_pushTime!),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: MyScreen.minFontSize(context),
                      decoration: TextDecoration.none),
                )
              ]),
            )),
        Positioned(
            bottom: _deviceHeight * 0.2,
            left: _deviceWidth * 0.02,
            child: Container(
              height: _deviceHeight * 0.25,
              width: _deviceWidth * 0.5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            )),
        Positioned(
            bottom: _deviceHeight * 0.1,
            left: _deviceWidth * 0.02,
            child: Container(
              height: _deviceHeight * 0.05,
              width: _deviceWidth * 0.6,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(10.0),
              ),
            )),
        _isOpenMessageTextField ? _sendMessageForm() : openMessegeWidget(),
      ];
    } else {
      list = [
        renderWidget(),
        countDownWidget(),
      ];
    }

    return list;
  }

  /// 相機背景畫面輸出
  Widget renderWidget() {
    return Container(
      color: Colors.black,
      child: Center(child: renderView()),
    );
  }

  ///叉叉離開直播
  Widget leavePushWidget() {
    return Positioned(
      right: _deviceWidth * 0.05,
      top: _deviceHeight * 0.1,
      child: CircleAvatar(
          radius: _deviceHeight * 0.03,
          backgroundColor: Colors.black.withOpacity(0.6),
          child: IconButton(
            iconSize: _deviceHeight * 0.03,
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              if (!_isStartPush) {
                Navigator.pop(context);
              } else {
                if (_socketClient != null) {
                  _socketClient!.disConnect();
                }

                ///結束直播後跳轉結束頁面
                NavigatorUtils.goLiveCameraPushFinishedPage(context,
                    userInfo: userInfo,
                    pushTimer: _pushTime,
                    getCoin: '',
                    views: '',
                    stream: _pushStream,
                    uid: userInfo.id,
                    token: userInfo.token);
              }
            },
          )),
    );
  }

  /// 倒數計時畫面
  Widget countDownWidget() {
    Widget w;
    if (pushCountDown > -1) {
      w = Positioned(
          top: _deviceHeight * 0.45,
          left: _deviceWidth * 0.45,
          child: Text(
            '$pushCountDown',
            style: TextStyle(
                color: Colors.white,
                fontSize: _deviceWidth * 0.3,
                decoration: TextDecoration.none),
          ));
    } else {
      w = Container();
    }
    return w;
  }

  initData() async {
    ///取得用戶資料
    var userRes = await UserInfoDao.getUserInfoLocal();

    setState(() {
      if (userRes != null) {
        if (userRes.result) {
          userInfo = userRes.data;
        }
      }
    });

    ///初始化計時
    _pushTime = DateTime.utc(0, 0, 0);

    ///發送訊息初始化
    _messageFormState = GlobalKey<FormState>();
    _messagesListViewController = ScrollController();
  }

  initLive() async {
    await initPlatformState();
    // 获取设备管理模块
    _txDeviceManager = _livePusher?.getDeviceManager();
    // 获取美颜管理对象
    _txBeautyManager = _livePusher?.getBeautyManager();
    // 获取音效管理类 TXAudioEffectManager
    _txAudioManager = _livePusher?.getAudioEffectManager();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    _livePusher = await V2TXLivePusher.create(widget.liveMode);
    _livePusher?.addListener(onPusherObserver);

    if (!mounted) return;
    setState(() {
      debugPrint("CreatePusher result is ${_livePusher?.status}");
    });
  }

  onPusherObserver(V2TXLivePusherListenerType type, param) {
    debugPrint("==pusher listener type= ${type.toString()}");
    debugPrint("==pusher listener param= $param");

    if (type == V2TXLivePusherListenerType.onMusicObserverStart) {
      setState(() {
        _audioSettings.isPlaying = true;
      });
    }
    if (type == V2TXLivePusherListenerType.onMusicObserverPlayProgress) {}
    if (type == V2TXLivePusherListenerType.onMusicObserverComplete) {
      setState(() {
        _audioSettings.isPlaying = false;
      });
    }
  }

  ///初始化push相關
  inintPushData() async {
    if (_livePusher == null) {
      return;
    }

    ///設定pusher相關
    await _livePusher?.setRenderMirror(_liveMirrorType);
    var videoEncoderParam = V2TXLiveVideoEncoderParam();
    videoEncoderParam.videoResolution = _resolution;
    videoEncoderParam.videoResolutionMode =
        V2TXLiveVideoResolutionMode.v2TXLiveVideoResolutionModePortrait;
    await _livePusher?.setVideoQuality(videoEncoderParam);
    await _livePusher?.setAudioQuality(widget.audioQuality);

    ///初始化會創建pushid
    if (_localViewId != null) {
      var code = await _livePusher?.setRenderViewID(_localViewId!);
      if (code != V2TXLIVE_OK) {
        showErrordDialog("StartPush error： please check remoteView load");
        return;
      }
    }

    ///打開camera
    var cameraCode = await _livePusher?.startCamera(true);
    if (cameraCode == null || cameraCode != V2TXLIVE_OK) {
      debugPrint("cameraCode: $cameraCode");
      showErrordDialog("Camera push error：please check Camera system auth.");
      return;
    }

    ///打開麥克風
    if (_microphoneEnable) {
      await _livePusher?.startMicrophone();
    }

    ///是否前置camera
    var isFrontCamera = await _txDeviceManager?.isFrontCamera();
    _isFrontCamera = isFrontCamera;
    debugPrint("current device isFrontCamera: $isFrontCamera");
    enableBeauty(_isOpenBeauty);
  }

  stopPush() async {
    await _livePusher?.stopMicrophone();
    await _livePusher?.stopCamera();
    await _livePusher?.stopPush();
  }

  void setMicrophone(bool enable) async {
    if (enable) {
      var code = await _livePusher?.startMicrophone();
      if (code != null && code == V2TXLIVE_OK) {
        setState(() {
          _microphoneEnable = true;
        });
      } else {
        showErrordDialog("please check microphone system auth");
        setState(() {
          _microphoneEnable = false;
        });
      }
    } else {
      await _livePusher?.stopMicrophone();
      setState(() {
        _microphoneEnable = enable;
      });
    }
  }

  void setLiveMirrorType(V2TXLiveMirrorType type) async {
    await _livePusher?.setRenderMirror(type);
    setState(() {
      _liveMirrorType = type;
    });
  }

  String _liveMirrorTitle() {
    if (_liveMirrorType == V2TXLiveMirrorType.v2TXLiveMirrorTypeAuto) {
      // front camera mirror only
      return "Auto";
    } else if (_liveMirrorType == V2TXLiveMirrorType.v2TXLiveMirrorTypeEnable) {
      // front and background camera mirror both
      return "Enable";
    } else {
      // front and background camera mirror disable
      return "Disable";
    }
  }

  void setLiveRotation(V2TXLiveRotation rotation) async {
    var code = await _livePusher?.setRenderRotation(rotation);
    debugPrint("setLiveRotation code: $code, rotation: $rotation ");
    if (code == V2TXLIVE_OK) {
      setState(() {
        _liveRotation = rotation;
      });
    } else {
      showErrordDialog("setLiveRotation error: code-$code");
    }
  }

  void setLiveVideoResolution(V2TXLiveVideoResolution resolution) async {
    var videoEncoderParam = V2TXLiveVideoEncoderParam();
    videoEncoderParam.videoResolution = resolution;
    await _livePusher?.setVideoQuality(videoEncoderParam);
    setState(() {
      _resolution = resolution;
    });
  }

  bool _isStartPush = false;
  Widget renderView() {
    return V2TXLiveVideoWidget(
      onViewCreated: (viewId) async {
        _localViewId = viewId;
        inintPushData();
      },
    );
  }

  // sdk出错信查看
  Future<bool?> showErrordDialog(errorMsg) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Alert"),
          content: Text(errorMsg),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  /// 打开音效面板
  void _showModalAudioSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return LiveAudioSheetPage(
          settings: _audioSettings,
          onMusicStartPlay: () async {
            debugPrint("onMusicStartPlay");
            await _txAudioManager?.startPlayMusic(_audioSettings.musicParam);
          },
          onMusicPausePlay: () async {
            debugPrint("onMusicPausePlay");
            await _txAudioManager?.pausePlayMusic(_audioSettings.musicParam.id);
          },
          onMusicStopPlay: () async {
            debugPrint("onMusicStopPlay");
            await _txAudioManager?.stopPlayMusic(_audioSettings.musicParam.id);
          },
          onAllMusicVolumeChanged: (value) async {
            debugPrint("onAllMusicVolumeChanged: $value");
            await _txAudioManager?.setAllMusicVolume(value);
          },
          onPublishVolumeChanged: (value) async {
            debugPrint("onPublishVolumeChanged: $value");
            await _txAudioManager?.setMusicPublishVolume(
                _audioSettings.musicParam.id, value);
          },
          onLocalVolumeChanged: (value) async {
            debugPrint("onLocalVolumeChanged: $value");
            await _txAudioManager?.setMusicPlayoutVolume(
                _audioSettings.musicParam.id, value);
          },
          onMusicPitchChanged: (value) async {
            debugPrint("onMusicPitchChanged: $value");
            await _txAudioManager?.setMusicPitch(
                _audioSettings.musicParam.id, value);
          },
          onSpeedRateChanged: (value) async {
            debugPrint("onSpeedRateChanged: $value");
            await _txAudioManager?.setMusicSpeedRate(
                _audioSettings.musicParam.id, value);
          },
        );
      },
    );
  }

//////////// 美顏相關設定&初始化 ////////
  initBeauty() async {
    _onPressed(context);
  }

  void _setBeautyListener() {
    TencentEffectApi.getApi()
        ?.setOnCreateXmagicApiErrorListener((errorMsg, code) {
      TXLog.printlog(
          "create xmaogicApi is error:  errorMsg = $errorMsg , code = $code");
    });

    TencentEffectApi.getApi()?.setAIDataListener(XmagicAIDataListenerImp());
    TencentEffectApi.getApi()?.setYTDataListener((data) {
      TXLog.printlog("setYTDataListener  $data");
    });
    TencentEffectApi.getApi()?.setTipsListener(XmagicTipsListenerImp());
  }

  void _removeBeautyListener() {
    TencentEffectApi.getApi()?.onPause();
    TencentEffectApi.getApi()?.setOnCreateXmagicApiErrorListener(null);
    TencentEffectApi.getApi()?.setAIDataListener(null);
    TencentEffectApi.getApi()?.setYTDataListener(null);
    TencentEffectApi.getApi()?.setTipsListener(null);
  }

  ///打开美颜操作，true表示开启美颜，FALSE表示关闭美颜
  ///true is turn on,false is turn off
  Future<int?> enableBeauty(bool open) async {
    if (open) {
      _setBeautyListener();
    } else {
      _removeBeautyListener();
    }

    ///开启美颜操作
    ///Turn on /off
    return await _livePusher?.enableCustomVideoProcess(open);
  }

  resetBeautySetting() async {
    _txBeautyManager?.setWhitenessLevel(0);
    _txBeautyManager?.setRuddyLevel(0);
    _txBeautyManager?.setBeautyLevel(0);
    TencentEffectApi.getApi()?.setOnCreateXmagicApiErrorListener(null);
    TencentEffectApi.getApi()?.setAIDataListener(null);
    TencentEffectApi.getApi()?.setYTDataListener(null);
    TencentEffectApi.getApi()?.setTipsListener(null);
  }

  /// 打开美颜面板
  /// show beauty pannel
  void _showModalBeautySheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return const PannelView(null);
      },
    );
  }

//////////// imagePicker 相關
  void _showImageActionSheet(BuildContext context) {
    showAdaptiveActionSheet(
        context: context,
        actions: <BottomSheetAction>[
          BottomSheetAction(
              title: Text(
                '相機',
                style: TextStyle(
                    fontSize: MyScreen.defaultTableCellFontSize(context)),
              ),
              onPressed: (val) {
                _pickImage(ImageSource.camera);
              }),
          BottomSheetAction(
              title: Text(
                '相冊',
                style: TextStyle(
                    fontSize: MyScreen.defaultTableCellFontSize(context)),
              ),
              onPressed: (val) {
                _pickImage(ImageSource.gallery);
              }),
        ],
        cancelAction: CancelAction(
            title: Text(
          '取消',
          style: TextStyle(
              color: Colors.red,
              fontSize: MyScreen.defaultTableCellFontSize(context)),
        )));
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.pop(context);
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
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

  ///創建主播房間
  void _callCreateRoomApi(
      String title, int liveClassId, int type, int typeVal, File? file) async {
    Map<String, dynamic> params = {};
    params["uid"] = userInfo.id;
    params["token"] = userInfo.token;
    params["user_nicename"] = userInfo.userNicename;
    params["avatar"] = userInfo.avatar;
    params["avatar_thumb"] = userInfo.avatarThumb;
    params["city"] = userInfo.city;
    params["province"] = userInfo.province;
    params["lat"] = "";
    params["lng"] = "";
    params["title"] = title;
    params["liveclassid"] = liveClassId;
    params["type"] = type;
    params["type_val"] = typeVal;
    if (file != null) {
      params["file"] = file;
    }
    var res = await LiveDao.createRoom(params: params);
    if (res != null) {
      if (res.data['code'] == 0) {
        setState(() {
          _pushAddress = res.data['info'][0]['push'];
          _pushStream = res.data['info'][0]['stream'];
        });

        ///創建房間成功後，把stream路徑推給騰訊直播
        var pushCode =
            await _livePusher?.startPush(res.data['info'][0]['push']);
        if (pushCode == null || pushCode != V2TXLIVE_OK) {
          showErrordDialog(
              "Camera push error：($pushCode) please check push url or LicenceURL");
          return;
        }

        ///連接sockeclient
        if (_socketClient == null) {
          _socketClient = SocketClient();
          _socketClient!.socketClient(res.data['info'][0]['chatserver']);
          // _socketClient!.connect(userInfo.id, res.data['info'][0]['stream']);
        }
      }
    }
  }

  ///倒數計時
  void pushCounter() {
    setState(() {
      _isStartPush = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            print('push count down -> $pushCountDown');
            pushCountDown--;

            ///倒數結束
            if (pushCountDown == -1) {
              _callCreateRoomApi(_editCtrl.text, _liveClassId, _liveType,
                  _liveTypeVal, _image);
              _pushTime = _pushTime!.add(const Duration(seconds: 1));
            } else if (pushCountDown < -1) {
              _pushTime = _pushTime!.add(const Duration(seconds: 1));
            }
          });
        });
      });
    });
  }

  /// 發送訊息widget
  Widget _sendMessageForm() {
    return Positioned(
        left: _deviceWidth * 0.02,
        bottom: () {
          if (_keyboardSize > 0.0) {
            return _keyboardSize + _deviceHeight * 0.01;
          } else {
            return _deviceHeight * 0.01;
          }
        }(),
        child: Container(
          height: _deviceHeight * 0.06,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Form(
            key: _messageFormState,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _messageTextField(),
                _sendMessageButton(),
              ],
            ),
          ),
        ));
  }

  ///輸入匡
  Widget _messageTextField() {
    return SizedBox(
      width: _deviceWidth * 0.65,
      child: SendTextFormField(
          onSaved: (_value) {},
          regEx: r"^(?!\s*$).+",
          hintText: "輸入些什麼吧 !",
          obscureText: false),
    );
  }

  ///發送按鈕
  Widget _sendMessageButton() {
    double _size = _deviceHeight * 0.04;
    return Container(
      height: _size,
      width: _size,
      child: IconButton(
        icon: Icon(
          Icons.send,
          color: Colors.white,
        ),
        onPressed: () {
          if (_messageFormState.currentState!.validate()) {
            _messageFormState.currentState!.save();

            _messageFormState.currentState!.reset();
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
      ),
    );
  }

  ///開啟聊天輸入匡
  Widget openMessegeWidget() {
    return Positioned(
      left: _deviceWidth * 0.05,
      bottom: _deviceHeight * 0.02,
      child: CircleAvatar(
          radius: _deviceHeight * 0.03,
          backgroundColor: Colors.black.withOpacity(0.6),
          child: IconButton(
            iconSize: _deviceHeight * 0.03,
            icon: const Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_isOpenMessageTextField) {
                  _isOpenMessageTextField = false;
                } else {
                  _isOpenMessageTextField = true;
                }
              });
            },
          )),
    );
  }
}

class XmagicAIDataListenerImp extends XmagicAIDataListener {
  @override
  void onBodyDataUpdated(String bodyDataList) {
    var result = json.decode(bodyDataList);
    if (result is List) {
      if (result.isNotEmpty) {
        var points = result[0]['points'];
        if (points is List && points.isNotEmpty) {
          TXLog.printlog("onBodyDataUpdated = ${points.length}");
        }
      }
    }
    TXLog.printlog("onBodyDataUpdated = $bodyDataList   ");
  }

  @override
  void onFaceDataUpdated(String faceDataList) {
    var result = json.decode(faceDataList);
    if (result is List) {
      if (result.isNotEmpty) {
        var points = result[0]['points'];
        if (points is List && points.isNotEmpty) {
          TXLog.printlog("onFaceDataUpdated = ${points.length}");
        }
      }
    }
    TXLog.printlog("onFaceDataUpdated = $faceDataList   ");
  }

  @override
  void onHandDataUpdated(String handDataList) {
    var result = json.decode(handDataList);
    if (result is List) {
      if (result.isNotEmpty) {
        var points = result[0]['points'];
        if (points is List && points.isNotEmpty) {
          TXLog.printlog("onHandDataUpdated = ${points.length}");
        }
      }
    }
    TXLog.printlog("onHandDataUpdated = $handDataList   ");
  }
}

class XmagicTipsListenerImp extends XmagicTipsListener {
  @override
  void tipsNeedHide(String tips, String tipsIcon, int type) {
    Fluttertoast.showToast(msg: tips);
  }

  @override
  void tipsNeedShow(String tips, String tipsIcon, int type, int duration) {}
}
