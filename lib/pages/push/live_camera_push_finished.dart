import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:queen/coomon/dao/LiveDao.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/models/userInfo.dart';

///
///
///直播結束後頁面
class LiveCameraPushFinishedPage extends StatefulWidget {
  final UserInfo userinfo;
  final DateTime? pushTimer;
  final String? getCoin;
  final String? views;
  final String? stream;
  final String? uid;
  final String? token;
  const LiveCameraPushFinishedPage(
      {super.key,
      required this.userinfo,
      this.pushTimer,
      this.getCoin,
      this.views,
      this.stream,
      this.uid,
      this.token});

  @override
  State<LiveCameraPushFinishedPage> createState() =>
      _LiveCameraPushFinishedPageState();
}

class _LiveCameraPushFinishedPageState
    extends State<LiveCameraPushFinishedPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return MaterialApp(
      home: Container(
          decoration: BoxDecoration(color: Colors.black),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.1),
              child: Center(
                child: Column(children: [
                  Text(
                    '直播已結束',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: MyScreen.defaultTableCellFontSize(context),
                        decoration: TextDecoration.none),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _deviceHeight * 0.03),
                      child: Material(
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: GestureDetector(
                            child: Image.network(
                          widget.userinfo.avatar,
                          scale: 4,
                          fit: BoxFit.cover,
                        )),
                      )),
                  Text(
                    '${widget.userinfo.userNicename}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MyScreen.defaultTableCellFontSize(context),
                        decoration: TextDecoration.none),
                  ),
                  Divider(
                    height: 2,
                    color: Colors.white.withOpacity(0.6),
                  ),
                  SizedBox(
                      height: _deviceHeight * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.Hms().format(widget.pushTimer!),
                                style: TextStyle(
                                    color: Colors.pink[100],
                                    fontSize: MyScreen.defaultTableCellFontSize(
                                        context),
                                    decoration: TextDecoration.none),
                              ),
                              Text(
                                '直播時長',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: MyScreen.minBigFontSize(context),
                                    decoration: TextDecoration.none),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.getCoin!.isEmpty ? '0' : widget.getCoin!,
                                style: TextStyle(
                                    color: Colors.pink[100],
                                    fontSize: MyScreen.defaultTableCellFontSize(
                                        context),
                                    decoration: TextDecoration.none),
                              ),
                              Text(
                                '收穫Q Coin',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: MyScreen.minBigFontSize(context),
                                    decoration: TextDecoration.none),
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.views!.isEmpty ? '0' : widget.views!,
                                style: TextStyle(
                                    color: Colors.pink[100],
                                    fontSize: MyScreen.defaultTableCellFontSize(
                                        context),
                                    decoration: TextDecoration.none),
                              ),
                              Text(
                                '觀看人數',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: MyScreen.minBigFontSize(context),
                                    decoration: TextDecoration.none),
                              )
                            ],
                          )
                        ],
                      )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[200],
                      minimumSize:
                          Size(_deviceWidth * 0.7, _deviceHeight * 0.06),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(
                      '返回首頁',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MyScreen.defaultTableCellFontSize(context)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ]),
              ))),
    );
  }

  _initData() async {
    _callStopRoomApi();
  }

  _callStopRoomApi() async {
    Map<String, dynamic> params = {};
    params['stream'] = widget.stream;
    params['uid'] = widget.uid;
    params['token'] = widget.token;
    var res = await LiveDao.stopRoom(params: params);
    if (res != null) {
      _callGetLiveEndInfoApi();
    }
  }

  _callGetLiveEndInfoApi() async {
    Map<String, dynamic> params = {};
    params['stream'] = widget.stream;
    var res = await LiveDao.getLiveEndInfo(params: params);
    if (res != null) {}
  }
}
