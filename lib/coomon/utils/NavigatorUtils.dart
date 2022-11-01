import 'package:flutter/material.dart';
import 'package:queen/pages/HomeNavigationBarPage.dart';
import 'package:queen/pages/SocketClientPage.dart';
import 'package:queen/pages/homePage/HomePage.dart';
import 'package:queen/pages/live_start_push.dart';
import 'package:queen/pages/loginPage/ForgotPwdPage.dart';
import 'package:queen/pages/loginPage/LoginPage.dart';
import 'package:queen/pages/loginPage/RegistPage.dart';

///
///導航欄
///Date: 2022-05-27
///
class NavigatorUtils {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ///替換
  static pushReplacementNamed(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  ///切換無參數頁面
  static pushNamed(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static removeAndPushNamed(String _route) {
    navigatorKey.currentState?.popAndPushNamed(_route);
  }

  ///刪除「先前所有」 route，push到新 route後，設為第一層
  static pushNamedAndRemoveUntil(String routeName) {
    navigatorKey.currentState
        ?.pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  ///一般跳轉頁面
  // ignore: non_constant_identifier_names
  static navigatorRouter(BuildContext context, Widget widget) {
    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }

  /// 返回上一頁
  static goBack() {
    navigatorKey.currentState?.pop();
  }

  ///取得當下route路徑
  String? getCurrentRoute() {
    return ModalRoute.of(navigatorKey.currentState!.context)?.settings.name!;
  }

  ///首頁
  ///pushReplacementNamed需要由main.dart做導航
  static goHomePage(BuildContext context) {
    pushReplacementNamed(HomePage.sName);
  }

  ///登入頁
  static goLoginPge() {
    pushNamedAndRemoveUntil(LoginPage.sName);
  }

  ///忘記密碼頁面
  static goForgotPwdPage(context) {
    navigatorRouter(context, ForgotPwdPage());
  }

  ///註冊頁面
  static goRegistPage(context) {
    navigatorRouter(context, RegistPage());
  }

  ///測試socket頁面
  static goSocketClientPage(context) {
    navigatorRouter(context, SocketClientPage());
  }

  ///開始直播推流
  static goCameraPushPage(context, {required LiveStartPushType pushtype}) {
    navigatorRouter(context, LiveStartPushPage(pushType: pushtype));
  }

  ///登入後首頁
  static goHomeNavigationBarPage(BuildContext context) {
    pushReplacementNamed(HomeNavigationBarPage.sName);
  }
}
