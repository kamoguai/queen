import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:live_flutter_plugin/v2_tx_live_player.dart';

import 'package:queen/coomon/dao/HomePageDao.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/models/liveList.dart';
import 'package:queen/models/userInfo.dart';
import 'package:queen/pages/LivePlay/LiveAudiencePage.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:queen/widgets/liveVodWidget.dart';

///
///
///Live 頁面
class LivePage extends StatefulWidget {
  const LivePage({super.key});

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage>
    with BaseWidget, TickerProviderStateMixin, RestorationMixin {
  late double _deviceWidth;
  late double _deviceHeight;
  late TabController _tabCtrl;

  ///0:直播，1:預計
  final RestorableInt tabIndex = RestorableInt(0);
  late AnimationController _animeCtrl;
  ScrollController scrollCtrl = ScrollController();
  V2TXLivePlayer? _livePlayer;
  int? _renderViewId;
  late UserInfo userInfo;
  late LiveList llModel;

  ///直播list
  List<LiveList> llModelList = [];

  ///預計list
  List<LiveList> llsModelList = [];
  List<String> menuTextList = [];

  @override
  String? get restorationId => 'home_live_tab';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabCtrl.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(initialIndex: 0, length: 2, vsync: this);
    _animeCtrl = AnimationController(
        vsync: this,
        value: 0,
        duration: const Duration(milliseconds: 150),
        reverseDuration: const Duration(milliseconds: 75))
      ..addStatusListener((status) {
        setState(() {});
      });
    _tabCtrl.addListener(() {
      setState(() {
        tabIndex.value = _tabCtrl.index;
      });
    });
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    _tabCtrl.dispose();
    tabIndex.dispose();
    _animeCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    localizations = AppLocalizations.of(context)!;
    return _buildUI();
  }

  Widget _buildUI() {
    final tabs = [localizations.homeLiveStream, localizations.homeLiveExpected];
    return Material(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: AppBar().preferredSize.height,
              width: double.infinity,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Row(children: [
                SizedBox(
                  width: _deviceWidth * 0.5,
                  child: TabBar(
                    controller: _tabCtrl,
                    isScrollable: false,
                    tabs: [
                      for (final tab in tabs)
                        Tab(
                          text: tab,
                        )
                    ],
                    labelStyle:
                        TextStyle(fontSize: MyScreen.appBarFontSize(context)),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.red,
                    onTap: (val) {
                      print('tab onclick -> $val');
                      print('tab val -> ${tabIndex.value}');
                    },
                  ),
                ),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  child:
                      SvgPicture.asset('assets/images/HomePage/newsearch.svg'),
                ),
                SizedBox(
                  width: _deviceWidth * 0.03,
                ),
                GestureDetector(
                  child: Image.asset('assets/images/HomePage/memubar.png'),
                  onTap: () {
                    if (_isAnimationRunningForwardsOrComplete) {
                      _animeCtrl.reverse();
                    } else {
                      _animeCtrl.forward();
                    }
                  },
                ),
              ]),
            ),
            AnimatedBuilder(
              animation: _animeCtrl,
              builder: ((context, child) {
                return FadeScaleTransition(
                  animation: _animeCtrl,
                  child: child,
                );
              }),
              child: Visibility(
                  visible: _animeCtrl.status != AnimationStatus.dismissed,
                  child: Container(
                    color: Colors.grey,
                    width: _deviceWidth,
                    height: AppBar().preferredSize.height,
                    child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: _menuBar()),
                  )),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
                child: Column(children: [
                  llModelList.isEmpty
                      ? Container()
                      : GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: scrollCtrl,
                          crossAxisCount: 2,
                          children: loopData(),
                        ),
                ]),
              ),
            )
          ],
        ));
  }

  Widget _vedioWidget(LiveList model) {
    Widget w;
    w = GestureDetector(
      child: LiveWidget(
        model: model,
      ),
      onTap: () async {
        if (tabIndex.value == 0) {
          String callback = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LiveAudiencePage(
                        streamerUID: model.streamerUID,
                        matchID: model.matchID,
                        channel: model.channel,
                      )));
          if (callback == "callback") {
            _callApiGetLiveList();
            _callApiGetScheduleLive();
          }
        }
      },
    );

    return w;
  }

  List<Widget> loopData() {
    List<Widget> w = [];
    if (tabIndex.value == 0) {
      if (llModelList.isNotEmpty) {
        for (var dic in llModelList) {
          w.add(_vedioWidget(dic));
        }
      } else {
        w.add(Container());
      }
    } else if (tabIndex.value == 1) {
      if (llsModelList.isNotEmpty) {
        for (var dic in llsModelList) {
          w.add(_vedioWidget(dic));
        }
      } else {
        w.add(Container());
      }
    }

    return w;
  }

  Widget _menuItem(String str) {
    Widget w;
    w = Container(
      height: AppBar().preferredSize.height,
      width: _deviceWidth / 4,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(color: Colors.white, width: 1))),
      child: Center(
          child: Text(
        str,
        style: TextStyle(color: Colors.white),
      )),
    );
    return w;
  }

  List<Widget> _menuBar() {
    List<Widget> list = [];
    for (var str in menuTextList) {
      list.add(_menuItem(str));
    }
    return list;
  }

  _initData() async {
    var userRes = await UserInfoDao.getUserInfoLocal();

    setState(() {
      if (userRes != null) {
        if (userRes.result) {
          userInfo = userRes.data;
          _callApiGetLiveList();
          _callApiGetScheduleLive();
        }
      }
      menuTextList = [
        localizations.liveSysRecommend,
        localizations.livePopular,
        localizations.liveAttentionAnchor,
        localizations.liveCustom
      ];
    });
  }

  ///取得live列表
  _callApiGetLiveList() async {
    Map<String, dynamic> params = {};
    params["uid"] = userInfo.id;
    params["token"] = userInfo.token;
    var res = await HomePageDao.getLiveList(params: params);
    if (res != null) {
      Map<String, dynamic> resMap = res.data;
      if (resMap["code"] == 0) {
        if (resMap["info"] != null) {
          List<dynamic> liveList = resMap["info"];
          setState(() {
            for (var dic in liveList) {
              llModel = LiveList.fromJson(dic);
              llModelList.add(llModel);
            }
          });
        }
      }
    }
  }

  ///取得live預計列表
  _callApiGetScheduleLive() async {
    Map<String, dynamic> params = {};
    params["uid"] = userInfo.id;
    params["token"] = userInfo.token;
    var res = await HomePageDao.getScheduleLive(params: params);
    if (res != null) {
      Map<String, dynamic> resMap = res.data;
      if (resMap["code"] == 0) {
        if (resMap["info"] != null) {
          List<dynamic> liveList = resMap["info"];
          setState(() {
            for (var dic in liveList) {
              llModel = LiveList.fromJson(dic);
              llsModelList.add(llModel);
            }
          });
        }
      }
    }
  }

  bool get _isAnimationRunningForwardsOrComplete {
    switch (_animeCtrl.status) {
      case AnimationStatus.forward:

      case AnimationStatus.completed:
        return true;
      case AnimationStatus.reverse:

      case AnimationStatus.dismissed:
        return false;
    }
  }
}
