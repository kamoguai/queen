class LiveChat {
  static const int normal = 0;
  static const int system = 1;
  static const int gift = 2;
  static const int enterRoom = 3;
  static const int light = 4;
  static const int redPack = 5;

  String id;
  String userNiceName;
  int level;
  String content;
  int heart;
  int type; //0是普通消息  1是系统消息 2是礼物消息
  String liangName;
  int vipType;
  int guardType;
  bool anchor;
  bool manager;
  LiveChat(
      {required this.id,
      required this.userNiceName,
      required this.level,
      required this.content,
      required this.heart,
      required this.type, //0是普通消息  1是系统消息 2是礼物消息
      required this.liangName,
      required this.vipType,
      required this.guardType,
      required this.anchor,
      required this.manager});

  String get getId => id;

  void setId(String id) {
    this.id = id;
  }

  String get getUserNiceName => userNiceName;

  void setUderNiceName(String userNiceName) {
    this.userNiceName = userNiceName;
  }

  int get getLevel => level;

  void setLevel(int level) {
    this.level = level;
  }

  String get getContent => content;

  void setConnect(String content) {
    this.content = content;
  }

  int get getHeart => heart;

  void setHeart(int heart) {
    this.heart = heart;
  }

  int get getType => type;

  void setType(int type) {
    this.type = type;
  }

  String get getLiangName => liangName;

  void setLiangName(String liangName) {
    this.liangName = liangName;
  }

  bool get isAnchor => anchor;

  void setAnchor(bool anchor) {
    this.anchor = anchor;
  }

  int get getVipType => vipType;

  void setVipType(int vipType) {
    this.vipType = vipType;
  }

  bool get isManager => manager;

  void setManager(bool manager) {
    this.manager = manager;
  }

  int get getGuardType => guardType;

  void setGuardType(int guardType) {
    this.guardType = guardType;
  }
}
