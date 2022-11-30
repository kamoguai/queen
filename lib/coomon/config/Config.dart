class Config {
  static const page_size = 20;
  static const debug = true;
  static const use_native_webview = true;
  static String appVer = "";
  static String mailRegEx =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static bool isVipMode = false;
  static bool isAutoLogin = true;

  ///騰訊美肌licence
  static String telicenceXmagicLicence =
      "https://license.vod2.myqcloud.com/license/v2/1309042385_1/v_cube.license";
  static String telicenceXmagicKey = "fd6ca0306a6489dfb45fbd5213c8c7d4";

  ///騰訊vod licence
  static String tencentVodLicenceUrl =
      "https://license.vod-control.com/license/v2/1309042385_1/v_cube.license";
  static String tencentVodLicenceKey = "fd6ca0306a6489dfb45fbd5213c8c7d4";

  ///騰訊短視頻licence
  static String tencentLicenceUrl =
      "http://license.vod2.myqcloud.com/license/v1/b3353fc2a05d4e24c216bb2575146d52/TXUgcSDK.licence";
  static String tencentLicenceKey = "486bb6ba4dee2a5c548cafee20e59d41";

  ///騰訊直播licence
  static String tencentLiveLicenceUrl =
      "http://license.vod2.myqcloud.com/license/v1/b3353fc2a05d4e24c216bb2575146d52/TXLiveSDK.licence";
  static String tencentLiveLicenceKey = "486bb6ba4dee2a5c548cafee20e59d41";

  ///騰訊播放器licence
  static String txLiveLicenceKey = "486bb6ba4dee2a5c548cafee20e59d41";
  static String txLiveLicenceUrl =
      "http://license.vod2.myqcloud.com/license/v1/b3353fc2a05d4e24c216bb2575146d52/TXLiveSDK.licence";

  /// //////////////////////////////////////常量////////////////////////////////////// ///

  static const sessionHeaders = "sessionHeaders";
  static const devices = "devices";
  static int currntPate = 0;
  static const userMobile = "userMobile";
  static const userPwd = "userPwd";
  static const userInfo = "userInfo";
  static const countryCode = "countryCode";
  static const liveUser = "liveUser";
}
