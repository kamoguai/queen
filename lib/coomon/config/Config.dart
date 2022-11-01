class Config {
  static const page_size = 20;
  static const debug = true;
  static const use_native_webview = true;
  static String appVer = "";
  static String mailRegEx =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static bool isVipMode = false;
  static bool isAutoLogin = true;

  /// //////////////////////////////////////常量////////////////////////////////////// ///

  static const sessionHeaders = "sessionHeaders";
  static const devices = "devices";
  static int currntPate = 0;
  static const userMobile = "userMobile";
  static const userPwd = "userPwd";
  static const userInfo = "userInfo";
}
