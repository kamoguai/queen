import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:live_flutter_plugin/v2_tx_live_def.dart';
import 'package:queen/coomon/dao/LiveDao.dart';
import 'package:queen/coomon/dao/UserInfoDao.dart';
import 'package:queen/coomon/style/MyStyle.dart';
import 'package:queen/coomon/utils/NavigatorUtils.dart';
import 'package:queen/models/liveUser.dart';
import 'package:queen/models/userInfo.dart';
import 'package:queen/pages/push/live_camera_push.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///
///
///設定個人資料頁面
///
class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> with BaseWidget {
  late double _deviceWidth;
  late double _deviceHeight;

  ///使用者資訊
  late UserInfo userInfo;

  ///直播使用者資訊
  late LiveUser liveUser;

  List<String> listItems = ['直播上播', '總收益', '提現', '充值提現紀錄', '設置'];

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.personProfile,
          style: TextStyle(
              color: Colors.grey, fontSize: MyScreen.appBarFontSize(context)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(),
        elevation: 0,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          margin: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Container(
              height: _deviceHeight * 0.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/Login/bg_login.png"),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: _deviceWidth * 0.02,
                    vertical: _deviceHeight * 0.01),
                child: Column(children: [
                  Container(
                    height: _deviceHeight * 0.09,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          shape: CircleBorder(),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: GestureDetector(
                              child: userInfo.avatarThumb.isEmpty
                                  ? Image.asset(
                                      'assets/images/1V1/icon_solo_avatar_holder.png',
                                      scale: 2.6,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      userInfo.avatarThumb,
                                      scale: 2.6,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        SizedBox(
                          width: _deviceWidth * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userInfo.userNicename.isEmpty
                                  ? ''
                                  : userInfo.userNicename,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyScreen.minBigFontSize(context)),
                            ),
                            SizedBox(
                              height: _deviceHeight * 0.01,
                            ),
                            Text(
                              'ID: ${userInfo.id.isEmpty ? '' : userInfo.id}',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: MyScreen.minBigFontSize(context)),
                            )
                          ],
                        ),
                        SizedBox(
                          width: _deviceWidth * 0.02,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              '0',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MyScreen.normalPageFontSize(context)),
                            ),
                            Text('關注',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MyScreen.normalPageFontSize(context)))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text('0',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MyScreen.normalPageFontSize(context))),
                            Text('粉絲',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MyScreen.normalPageFontSize(context)))
                          ],
                        ),
                      )
                    ],
                  )
                ]),
              )),
        ),
        SizedBox(
          height: _deviceHeight * 0.05,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: _deviceHeight * 0.15,
                  width: _deviceWidth * 0.5 - _deviceWidth * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/images/game/bacca/allcards/金幣底色.png"),
                    ),
                  ),
                ),
                Container(
                  height: _deviceHeight * 0.15,
                  width: _deviceWidth * 0.5 - _deviceWidth * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                          "assets/images/game/bacca/allcards/票卷底色.png"),
                    ),
                  ),
                ),
              ],
            )),
        SizedBox(
          height: _deviceHeight * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Image.asset(
                    width: _deviceWidth * 0.15,
                    height: _deviceHeight * 0.08,
                    'assets/images/game/bacca/allcards/newprofileTop.png'),
                Text(
                  '商店',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: MyScreen.minFontSize(context)),
                ),
              ]),
              onTap: () {
                NavigatorUtils.goAppPurchasePage(context);
              },
            ),
            GestureDetector(
              child: Column(children: [
                Image.asset(
                    width: _deviceWidth * 0.15,
                    height: _deviceHeight * 0.08,
                    'assets/images/game/bacca/allcards/newprofileAward.png'),
                Text(
                  '排行',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: MyScreen.minFontSize(context)),
                )
              ]),
            ),
            GestureDetector(
                child: Column(children: [
              Image.asset(
                  width: _deviceWidth * 0.15,
                  height: _deviceHeight * 0.08,
                  'assets/images/game/bacca/allcards/msgVector.png'),
              Text(
                '消息',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: MyScreen.minFontSize(context)),
              )
            ]))
          ],
        ),
        SizedBox(
          height: _deviceHeight * 0.03,
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return titleItems(index)[index];
            },
            separatorBuilder: (context, index) {
              return const Divider(
                color: Colors.white,
                height: 2,
              );
            },
            itemCount: titleItems(-1).length),
      ]),
    );
  }

  _initData() async {
    userInfo = UserInfo(
        id: '',
        userNicename: '',
        avatar: '',
        avatarThumb: '',
        sex: '',
        signature: '',
        coin: '',
        consumption: '',
        votestotal: '',
        province: '',
        city: '',
        birthday: '',
        loginType: '',
        jimName: '',
        jimPass: '',
        timUsersig: '',
        isreg: '',
        isStore: '',
        level: '',
        levelAnchor: '',
        token: '');

    liveUser = LiveUser(
        isdnd: '',
        fans: '',
        id: '',
        country: '',
        level: '',
        bgImg: '',
        avatarThumb: '',
        votes: '',
        liveStatus: 0,
        singleAnswer: '',
        votestotal: '',
        coin: '',
        levelAnchor: '',
        sex: '',
        userLogin: '',
        videoCount: '',
        birthday: '',
        singleSwitch: '',
        city: '',
        avatar: '',
        lastConn: '',
        lives: 0,
        userNicename: '',
        consumption: '',
        province: '',
        singleCharge: '',
        follows: '',
        userAuth: 0,
        authVideo: '',
        constellation: '',
        liang: {},
        liveAuth: '',
        money: 0,
        signature: '',
        singleImg: '',
        singleRefuse: '',
        vip: {});
    var userRes = await UserInfoDao.getUserInfoLocal();

    var liveUserRes = await LiveDao.getLiveUserLocal();
    setState(() {
      if (userRes != null) {
        if (userRes.result) {
          userInfo = userRes.data;
        }
      }
      if (liveUserRes != null) {
        if (liveUserRes.result) {
          liveUser = liveUserRes.data;
        }
      }
    });
  }

  List<Widget> titleItems(int index) {
    List<Widget> list = [];
    String svgPath = '';
    for (var dic in listItems) {
      if (liveUser.liveAuth == '0') {
        if (dic == '直播上播') {
          continue;
        }
      }
      switch (dic) {
        case '直播上播':
          svgPath = 'assets/images/MyProfile/直播上播.svg';
          break;
        case '總收益':
        case '提現':
          svgPath = 'assets/images/MyProfile/icon_profile_profit.svg';
          break;
        case '充值提現紀錄':
          break;
        case '設置':
          svgPath = 'assets/images/MyProfile/icon_profile_setting.svg';
          break;
      }
      list.add(ListTile(
        tileColor: Colors.grey[200],
        leading: SvgPicture.asset(svgPath),
        title: Text(
          dic,
          style: TextStyle(
              color: Colors.grey,
              fontSize: MyScreen.defaultTableCellFontSize(context)),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {},
        ),
        contentPadding: const EdgeInsets.all(10),
        onTap: () {
          if (dic == '設置') {
            NavigatorUtils.goSettingPage(context);
          } else if (dic == '直播上播') {
            _showLiveOrRecordBottomModalSheet(context);
          }
        },
      ));
    }

    return list;
  }

  ///直播或錄影的dialog
  void _showLiveOrRecordBottomModalSheet(BuildContext context) {
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100), topRight: Radius.circular(100))),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100)),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/Login/bg_login.png"),
                  ),
                ),
                height: _deviceHeight * 0.3,
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: GestureDetector(
                            onTap: () {
                              startCameraLive(
                                  context, V2TXLiveMode.v2TXLiveModeRTMP);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/MyProfile/icon_profile_start_live.png',
                                  scale: 2.6,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: _deviceHeight * 0.02,
                                ),
                                Text(
                                  '立即直播',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MyScreen.defaultTableCellFontSize(
                                              context)),
                                )
                              ],
                            ))),
                    Expanded(
                        child: GestureDetector(
                            child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/MyProfile/icon_profile_start_video.png',
                          scale: 2.6,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: _deviceHeight * 0.02,
                        ),
                        Text(
                          '拍攝視頻',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MyScreen.defaultTableCellFontSize(context)),
                        )
                      ],
                    )))
                  ],
                ));
          });
        });
  }

  /// 摄像头推流
  startCameraLive(BuildContext context, V2TXLiveMode liveMode) {
    /// 直播流id
    String _streamId = '123456';

    /// 当前音频质量
    V2TXLiveAudioQuality _audioQuality =
        V2TXLiveAudioQuality.v2TXLiveAudioQualityDefault;

    ///先把dialog關掉
    Navigator.pop(context);
    LiveCameraPushPage page = LiveCameraPushPage(
        audioQuality: _audioQuality, streamId: _streamId, liveMode: liveMode);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
