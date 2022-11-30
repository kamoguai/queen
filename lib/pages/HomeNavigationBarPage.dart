import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:queen/helper/permissionHelper.dart';
import 'package:queen/pages/homePage/HomePage.dart';
import 'package:queen/pages/homePage/LivePage.dart';
import 'package:queen/pages/homePage/MyProfilePage.dart';
import 'package:queen/pages/homePage/VodPage.dart';
import 'package:queen/providers/BottomNavigationBarProvider.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:queen/widgets/CommonUIWidget.dart';

///
///
///主要bottomBar導航頁面
///
class HomeNavigationBarPage extends StatefulWidget {
  static const String sName = "/root";
  const HomeNavigationBarPage({super.key});

  @override
  State<HomeNavigationBarPage> createState() => _HomeNavigationBarPageState();
}

class _HomeNavigationBarPageState extends State<HomeNavigationBarPage>
    with BaseWidget {
  late double _deviceHeight;
  late double _deviceWidth;
  late BottomNavigationBarProvider _bottomNavProvider;
  final Widget svg = SvgPicture.asset(
    'assets/images/Tabbar/icon_tabbar_video/短視頻icon套件.svg',
  );
  final List<Widget> _page = [
    const HomePage(),
    const LivePage(),
    const VodPage(),
    Container(
      color: Colors.white,
    ),
    const MyProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      checkPermissions();
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _bottomNavProvider = Provider.of<BottomNavigationBarProvider>(context);
    return _buildUI();
  }

  Widget _buildUI() {
    return WillPopScope(
        child: Container(
          color: Colors.white,
          child: SafeArea(
            child: CommonUIWidget(
              bottomNavigationBarProvider: _bottomNavProvider,
              body: _page[_bottomNavProvider.currentIndex],
            ),
          ),
        ),
        onWillPop: () {
          return exitDialog(context);
        });
  }

  void checkPermission() async {
    Permission permission = Permission.storage;
    PermissionStatus status = await permission.status;
    print('權限檢查：$status');

    if (status.isGranted) {
      ///權限通過

    } else if (status.isDenied) {
      ///權限拒絕，需區分ios , android
      requestPermission(permission);
    } else if (status.isPermanentlyDenied) {
      ///權限永久拒絕，且不提示，
      openAppSettings();
    } else if (status.isRestricted) {
      ///活動限制
      openAppSettings();
    } else {
      requestPermission(permission);
    }
  }

  void requestPermission(Permission permission) async {
    ///發起權限
    PermissionStatus status = await permission.request();

    ///返回權限申請狀態
    print('權限狀態：$status');
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void checkPermissions() {
    List<Permission> permissions = [
      Permission.storage,
      Permission.location,
      Permission.camera,
      Permission.microphone
    ];
    PermissionHelper.check(permissions, onSuccess: () {
      print('onSuccess');
    }, onFailed: () {
      print('onFialed');
    }, onOpenSetting: () {
      print('onOpenSetting');
      openAppSettings();
    });
  }
}
