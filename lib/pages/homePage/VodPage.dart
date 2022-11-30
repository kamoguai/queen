import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:queen/coomon/dao/HomePageDao.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/models/userInfo.dart';
import 'package:queen/models/videoList.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
///
///vod頁面
class VodPage extends StatefulWidget {
  const VodPage({super.key});

  @override
  State<VodPage> createState() => _VodPageState();
}

class _VodPageState extends State<VodPage>
    with BaseWidget, SingleTickerProviderStateMixin, RestorationMixin {
  late double _deviceWidth;
  late double _deviceHeight;
  late TabController _tabCtrl;
  final RestorableInt tabIndex = RestorableInt(0);
  ScrollController scrollCtrl = ScrollController();
  late UserInfo userInfo;
  late VideoList videoListModel;
  late VideoUserInfo videoUserInfo;

  ///球賽list
  List<VideoList> vlModelList = [];

  ///生活list
  List<VideoList> vllModelList = [];

  List<VideoList> finalModelList = [];

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
    if (!mounted) return;
    _tabCtrl = TabController(initialIndex: 0, length: 2, vsync: this);

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
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    localizations = AppLocalizations.of(context)!;
    return _buildUI();
  }

  Widget _buildUI() {
    final tabs = [localizations.homeVodMatch, localizations.homeVodLive];

    return Column(
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
                indicatorWeight: 4.0,
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (val) {},
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/HomePage/newsearch.svg',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: _deviceWidth * 0.03,
                  ),
                  GestureDetector(
                    child: SvgPicture.asset(
                      'assets/images/首页热门/liveIconMan.svg',
                      height: AppBar().preferredSize.height * 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Expanded(
          child: Stack(
            children: [
              vlModelList.isEmpty
                  ? showLoadingAnime(context)
                  : GridView.count(
                      controller: scrollCtrl,
                      crossAxisCount: 3,
                      children: _loopData(),
                    ),
              Positioned(
                  right: 0,
                  left: 0,
                  bottom: _deviceHeight * 0.03,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      NavigatorUtils.goRecordVideoPage(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: _deviceHeight * 0.04,
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }

  ///vod 物件
  Widget _gridItem(VideoList model) {
    Widget w;

    Widget images = Material(
        child: Image.network(
      model.thumbS,
      fit: BoxFit.cover,
    ));

    w = GestureDetector(
        onTap: () {
          if (tabIndex.value == 0) {
            finalModelList.clear();
            finalModelList.addAll(vlModelList);
          } else {
            finalModelList.clear();
            finalModelList.addAll(vllModelList);
          }
          NavigatorUtils.goVideoScrollPage(context,
              videoListModelList: finalModelList, videoListModel: model);
        },
        child: GridTile(
          footer: Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(color: Colors.black45),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: AlignmentDirectional.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: Row(children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            model.views,
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                      ),
                      SizedBox(
                        width: _deviceWidth * 0.1,
                      ),
                      SizedBox(
                        child: Row(children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                          Text(
                            model.likes,
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                      ),
                    ]),
              ),
            ),
          ),
          child: images,
        ));

    return w;
  }

  _loopData() {
    List<Widget> w = [];
    if (tabIndex.value == 0) {
      if (vlModelList.isNotEmpty) {
        for (var dic in vlModelList) {
          w.add(_gridItem(dic));
        }
      } else {
        w.add(Container());
      }
    } else if (tabIndex.value == 1) {
      if (vllModelList.isNotEmpty) {
        for (var dic in vllModelList) {
          w.add(_gridItem(dic));
        }
      } else {
        w.add(Container());
      }
    }

    return w;
  }

  _initData() async {
    var userRes = await UserInfoDao.getUserInfoLocal();

    setState(() {
      if (userRes != null) {
        if (userRes.result) {
          userInfo = userRes.data;
          _callApiGetVideoList();
        }
      }
    });
  }

  _callApiGetVideoList() async {
    Map<String, dynamic> params = {};
    params["uid"] = userInfo.id;
    params["token"] = userInfo.token;
    params["type"] = "0";
    params["p"] = "1";
    var res = await HomePageDao.getVideoList(params: params);
    if (res != null) {
      Map<String, dynamic> resMap = res.data;
      if (resMap["code"] == 0) {
        Map<String, dynamic> infoMap = resMap["info"][0];
        List<dynamic> videolist = infoMap["videolist"];

        setState(() {
          vlModelList.clear();
          int tag = 0;
          for (var dic in videolist) {
            videoListModel = VideoList.fromJson(dic, tag);
            vlModelList.add(videoListModel);
            vllModelList.add(videoListModel);
            tag++;
          }
        });
      }
    }
  }
}
