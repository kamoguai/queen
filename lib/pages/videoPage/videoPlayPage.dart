import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:queen/coomon/config/Config.dart';
import 'package:queen/models/videoList.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:super_player/super_player.dart';

///
///
///騰訊播放器播放頁面
class VideoPlayPage extends StatefulWidget {
  final VideoList videoListModel;
  const VideoPlayPage({Key? key, required this.videoListModel})
      : super(key: key);

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> with BaseWidget {
  TXVodPlayerController playCtrl = TXVodPlayerController();
  double _aspectRatio = 0.0;
  late double _deviceHeight;
  late double _deviceWidth;

  @override
  void initState() {
    super.initState();

    initData();
  }

  @override
  void dispose() {
    super.dispose();
    playCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Material(
      child: _body(),
    );
  }

  Widget _body() {
    Widget w;
    w = SafeArea(
        child: Stack(
      children: [
        _aspectRatio > 0
            ? ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: TXPlayerVideo(controller: playCtrl),
              )
            : Container(
                color: Colors.black,
              ),
        Positioned(
            top: _deviceHeight * 0.02,
            left: _deviceWidth * 0.02,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            )),
      ],
    ));
    return w;
  }

  initData() async {
    FTXVodPlayConfig config = FTXVodPlayConfig();
    await playCtrl.initialize();
    // 监听视频宽高变化，设置合适的宽高比例,也可自行设置宽高比例，视频纹理也会根据比例进行相应拉伸
    playCtrl.onPlayerNetStatusBroadcast.listen((event) async {
      double w = (event["VIDEO_WIDTH"]).toDouble();
      double h = (event["VIDEO_HEIGHT"]).toDouble();

      if (w > 0 && h > 0) {
        setState(() {
          debugPrint('VIDEO_WIDTH -> $w');
          debugPrint('VIDEO_HEIGHT -> $h');
          _aspectRatio = 0.85 * w / h;
          debugPrint('_aspectRatio -> $_aspectRatio');
        });
      }
    });
    playCtrl.startVodPlay(widget.videoListModel.href);
  }
}
