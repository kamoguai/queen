import 'package:queen/models/liveChat.dart';

abstract class SocketMessageListener {
  ///直播間，連接成功socket後調用
  void onConnect(bool successConn);

  ///直播間，斷開socket
  void onDisConnect();

  ///直播間，收到聊天消息
  void onChat(LiveChat model);

  ///直播間，收到飄心消息
  void onLight();

  ///直播間，收到用戶進房間消息
  void onEnterRoom();
}
