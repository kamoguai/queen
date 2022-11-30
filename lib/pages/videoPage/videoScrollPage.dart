import 'package:flutter/material.dart';

import 'package:queen/coomon/config/Config.dart';
import 'package:queen/models/videoList.dart';
import 'package:queen/pages/videoPage/videoPlayPage.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:super_player/super_player.dart';

///
///
///scroll vod頁面
class VedioScrollPage extends StatefulWidget {
  final List<VideoList> videoListModeList;
  final VideoList videoListMode;
  const VedioScrollPage(
      {Key? key, required this.videoListModeList, required this.videoListMode})
      : super(key: key);

  @override
  State<VedioScrollPage> createState() => _VedioScrollPageState();
}

class _VedioScrollPageState extends State<VedioScrollPage> with BaseWidget {
  ///圖片滑動controller
  PageController _pageViewCtrl = PageController();

  int nowVideoTag = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return SafeArea(
        child: Material(
      child: PageView(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {},
        controller: _pageViewCtrl,
        children: loopWidget(),
      ),
    ));
  }

  List<Widget> loopWidget() {
    List<Widget> list = [];
    for (var model in widget.videoListModeList) {
      list.add(VideoPlayPage(videoListModel: model));
    }
    return list;
  }

  ///初始化設定播放器licence
  setupLicense() {
    SuperPlayerPlugin.setGlobalLicense(
        Config.txLiveLicenceUrl, Config.txLiveLicenceKey);
  }

  initData() async {
    setupLicense();
    nowVideoTag = widget.videoListMode.tag;
    _pageViewCtrl = PageController(initialPage: nowVideoTag);
  }
}
