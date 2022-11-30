class Address {
  static String baseUrl = "http://www.kj176.com/";
  static String baseUrlPublic = "http://www.kj176.com/api/public/";
  static String baseUrlNewPublic = "http://119.28.17.240:30000/api/";
  static String apiPublic = "api/public/";
  static String loginPath = "?service=Login.userLogin";

  ///取得live列表
  static String getLiveList() {
    return "${baseUrlNewPublic}GetLiveList";
  }

  ///取得live預定列表
  static String getScheduleLive() {
    return "${baseUrlNewPublic}GetScheduleLive";
  }

  ///取得live新聞
  static String getLiveNews() {
    return "${baseUrlNewPublic}GetLiveNews";
  }

  ///thirdLogin
  static String thirdLogin() {
    return "$baseUrlPublic?service=thirdLogin.login";
  }

  ///mobileLogin
  static mobileLogin() {
    return "$baseUrl$apiPublic$loginPath";
  }

  ///facebookLogin
  static String facebookLogin() {
    return "$baseUrlPublic?service=thirdLogin.login";
  }

  ///zaloLogin
  static String zaloLogin() {
    return "$baseUrlPublic?service=thirdLogin.login";
  }

  ///取得註冊驗證碼
  static String getCapcha() {
    return "$baseUrl$apiPublic?service=Login.getCode";
  }

  ///註冊
  static String registMobile() {
    return "$baseUrl$apiPublic?service=Login.userReg";
  }

  ///取得註冊驗證碼
  static String getForgotCapcha() {
    return "$baseUrl$apiPublic?service=Login.getForgetCode";
  }

  ///取回使用者密碼
  static String getUserFindPass() {
    return "$baseUrl$apiPublic?service=Login.userFindPass";
  }

  ///直播地址
  static String getLiveVideoURL() {
    return "${baseUrlNewPublic}GetLiveVideoURL";
  }

  ///取得homeVod
  static String getHomeVideo() {
    return "$baseUrlPublic?service=Video.getHomeVideo";
  }

  ///取得vod列表
  static String getVideoList() {
    return "$baseUrlPublic?service=Video.getVideoList";
  }

  ///主播開播
  static String createRoom() {
    return "$baseUrlPublic?service=Live.createRoom";
  }

  ///結束直播
  static String stopRoom() {
    return "$baseUrlPublic?service=Live.stopRoom";
  }

  ///結束直播資訊
  static String getLiveEndInfo() {
    return "$baseUrlPublic?service=Live.stopInfo";
  }

  ///取得用戶資料
  static String getAnchor() {
    return "$baseUrlPublic?service=Anchor.getAnchorInfo";
  }
}
