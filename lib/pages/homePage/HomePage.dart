import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:queen/coomon/dao/HomePageDao.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/models/liveList.dart';
import 'package:queen/models/liveNews.dart';
import 'package:queen/models/userInfo.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:queen/widgets/code4carousel.dart';

///
///
///首頁頁面
///
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String sName = "/home";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BaseWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  ScrollController scrollCtrl = ScrollController();
  late UserInfo userInfo;

  late LiveNews lnModel;
  late LiveList llModel;
  List<LiveNews> lnModelList = [];
  List<LiveList> llModelList = [];
  var scrollImages = [
    'assets/images/girls/girl1.jpg',
    'assets/images/girls/girl2.jpg',
    'assets/images/girls/girl3.jpg',
    'assets/images/girls/girl4.jpg'
  ];

  PageController pageCtrl = PageController();
  PageView pView = PageView();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    localizations = AppLocalizations.of(context)!;
    return _buildUI();
  }

  Widget _buildUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: _deviceHeight * 0.3,
          child: Stack(
            children: [
              Positioned(
                  child: Material(
                child: Container(
                  height: _deviceHeight * 0.3,
                  width: _deviceWidth,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: const Offset(-10.0, 10.0),
                            blurRadius: 20.0,
                            spreadRadius: 4.0)
                      ]),
                ),
              )),
              Code4carousel(
                  imagePaths: scrollImages,
                  height: _deviceHeight * 0.3,
                  imageListSize: scrollImages.length)
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
            controller: scrollCtrl,
            child: Column(
              children: [
                SizedBox(
                  height: _deviceHeight * 0.02,
                ),
                Container(
                  height: _deviceHeight * 0.05,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.5))),
                  child: Row(children: [
                    Container(
                      width: _deviceWidth * 0.02,
                      height: _deviceWidth * 0.02,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: _deviceWidth * 0.01,
                    ),
                    Text(localizations.homePageNewsPush),
                    Expanded(child: Container()),
                    SizedBox(
                      width: _deviceWidth * 0.15,
                      child: Stack(
                        children: [
                          Positioned(
                            right: 20,
                            top: 10,
                            child: SvgPicture.asset(
                              'assets/images/HomePage/home_message/信息icon.svg',
                              width: _deviceWidth * 0.06,
                              height: _deviceWidth * 0.06,
                            ),
                          ),
                          Positioned(
                              right: 10,
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      '${lnModelList.length}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              MyScreen.minFontSize(context)),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: _deviceHeight * 0.03,
                ),
                lnModelList.isNotEmpty
                    ? Container()
                    : GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        controller: scrollCtrl,
                        crossAxisCount: 2,
                        children: loopData(),
                      ),
                SizedBox(
                  height: _deviceHeight * 0.03,
                ),
                Container(
                  height: _deviceHeight * 0.05,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.5))),
                  child: Row(children: [
                    Container(
                      width: _deviceWidth * 0.02,
                      height: _deviceWidth * 0.02,
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: _deviceWidth * 0.01,
                    ),
                    Text(localizations.homePageNews),
                    Expanded(child: Container()),
                  ]),
                ),
                SizedBox(
                  height: _deviceHeight * 0.02,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _titleItems(index)[index];
                  },
                  itemCount: _titleItems(-1).length,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _vedioWidget(LiveList model) {
    Widget w;
    w = GestureDetector(
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  fit: BoxFit.fill, image: NetworkImage(model.thumbURL))),
          child: Stack(children: [
            Positioned(
              top: 0,
              left: 0,
              child:
                  Image.asset('assets/images/HomePage/livecorner/LIVE套件.png'),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: _deviceWidth * 0.43,
                  height: _deviceHeight * 0.03,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.6),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      model.moduleTitle,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ))
          ]),
        ),
      ),
      onTap: () {
        debugPrint(model.matchID);
      },
    );

    return w;
  }

  List<Widget> loopData() {
    List<Widget> w = [];
    if (llModelList.isNotEmpty) {
      for (var dic in llModelList) {
        w.add(_vedioWidget(dic));
      }
    } else {
      w.add(Container());
    }

    return w;
  }

  Widget _titleItem(LiveNews model) {
    Widget w = ListTile(
      title: Text(model.time),
      trailing: Text(
        model.title,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        debugPrint('click listTitle');
      },
    );

    return w;
  }

  List<Widget> _titleItems(int index) {
    List<Widget> w = [];
    if (lnModelList.isNotEmpty) {
      for (var dic in lnModelList) {
        w.add(_titleItem(dic));
      }
    } else {
      w.add(const ListTile());
    }
    return w;
  }

  ///取得live列表
  _callApiGetProdList() async {
    Map<String, dynamic> params = {};
    params["uid"] = userInfo.id;
    params["token"] = userInfo.token;
    var res = await HomePageDao.productList(params: params);
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

  ///取得live新聞
  _callApiNewsList() async {
    Map<String, dynamic> params = {};
    params["uid"] = userInfo.id;
    params["token"] = userInfo.token;
    var res = await HomePageDao.newsList(params: params);
    if (res != null) {
      Map<String, dynamic> resMap = res.data;
      if (resMap["code"] == 0) {
        List<dynamic> newsList = resMap["info"];
        setState(() {
          for (var dic in newsList) {
            lnModel = LiveNews.fromJson(dic);

            lnModelList.add(lnModel);
          }
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
          _callApiGetProdList();
          _callApiNewsList();
        }
      }
    });
  }
}
