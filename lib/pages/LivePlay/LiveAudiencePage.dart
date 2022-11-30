import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:queen/coomon/dao/HomePageDao.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/models/liveVideoUrl.dart';
import 'package:queen/models/userInfo.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
///
/// 首頁live 直播
///
class LiveAudiencePage extends StatefulWidget {
  final String? streamerUID;
  final String? matchID;
  final String? channel;
  const LiveAudiencePage(
      {super.key, this.streamerUID, this.matchID, this.channel});

  @override
  State<LiveAudiencePage> createState() => _LiveAudiencePageState();
}

class _LiveAudiencePageState extends State<LiveAudiencePage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late UserInfo userInfo;
  late LiveVideoUrl liveVideoUrlModel;
  List<LiveVideoUrl> lvuList = [];

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
    return WillPopScope(
      child: _buildUI(),
      onWillPop: () async {
        Navigator.pop(context, 'callback');
        return true;
      },
    );
  }

  Widget _buildUI() {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: GestureDetector(child: Text('切換模式')),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Navigator.pop(context, 'callback');
              },
            ),
          ),
          body: _body()),
    );
  }

  Widget _body() {
    Widget w;
    if (lvuList.isEmpty) {
      w = Container(
        color: Colors.black,
      );
    } else {
      liveVideoUrlModel = lvuList[0];
      w = Column(children: [
        Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              child: WebView(
                initialUrl: liveVideoUrlModel.h5link,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            )),
        Container(
          color: Colors.black,
          height: _deviceHeight * 0.01,
          width: double.infinity,
        ),
        Expanded(
            flex: 1,
            child: Stack(
              children: [
                liveVideoUrlModel.streamerURL.isEmpty
                    ? Container(
                        color: Colors.black,
                      )
                    : Container(
                        width: double.infinity,
                        child: WebView(
                          initialUrl: liveVideoUrlModel.streamerURL,
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                // Positioned(
                //     top: 20,
                //     child: ElevatedButton(
                //       child: Text('test'),
                //       onPressed: () {},
                //     ))
              ],
            )),
      ]);
    }

    return w;
  }

  _callApiGetLiveUrl() async {
    Map<String, dynamic> params = {};
    params["uid"] = userInfo.id;
    params["token"] = userInfo.token;
    params["ip"] = "61.222.22.22";
    params["streamerUID"] = widget.streamerUID;
    params["matchID"] = widget.matchID;
    params["channel"] = widget.channel;
    var res = await HomePageDao.getLiveVideoURL(params: params);
    if (res != null) {
      Map<String, dynamic> resMap = res.data;
      if (resMap["code"] == 0) {
        Map<String, dynamic> infoMap = resMap["info"];

        setState(() {
          liveVideoUrlModel = LiveVideoUrl.fromJson(infoMap);
          lvuList.add(liveVideoUrlModel);
        });
      }
    }
  }

  _initData() async {
    var userRes = await UserInfoDao.getUserInfoLocal();

    setState(() {
      if (userRes != null) {
        if (userRes.result) {
          userInfo = userRes.data;
          _callApiGetLiveUrl();
        }
      }
    });
  }
}
