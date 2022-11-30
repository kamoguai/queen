import 'dart:convert';

import 'package:queen/coomon/socket/socketSendModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as sio;

///客製化socketClient
///
///
class SocketClient {
  final String _tag = 'socket';
  sio.Socket? _socket;
  String? _liveUid;
  String? _stream;
  String? _roomNum;

  socketClient(String url) {
    _socket = sio.io(
        url,
        sio.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .enableAutoConnect()
            .setReconnectionDelay(200)
            .build());

    ///連接成功
    _socket!.on('connect', (_) {
      print('socket io is connected');
      _socket!.emit('broadcastingListen');
      _socket!.emitWithAck('broadcastingListen', 'init', ack: (data) {
        print('socket io ack -> $data');
        if (data != null) {
          print('socket io  from server -> $data');
        } else {
          print('socket io null');
        }
      });
    });

    ///斷開連線
    _socket!.on('disconnect', (_) {
      print('socket io is disconnect');
    });

    ///連接錯誤
    _socket!.on('connect_error', (data) {
      print('socket io has connect error -> $data');
    });

    ///連接socket消息
    _socket!.on('conn', (data) {
      print('socket io connet msg -> $data');
    });

    ///接收server廣播
    _socket!.on('broadcastingListen', (data) {
      print('get server message -> $data');
    });
  }

  connect(String liveuid, String stream) {
    _liveUid = liveuid;
    _stream = stream;
    if (_socket != null) {
      _socket!.connect();
    }
  }

  disConnect() {
    if (_socket != null) {
      _socket!.close();
    }
  }

  setRoomNum(String roomNum) {
    _roomNum = roomNum;
  }

  conn(String uid, String token) {
    Map<String, dynamic> params = {};
    try {
      params["uid"] = uid;
      params["token"] = token;
      params["liveuid"] = _liveUid;
      if (_roomNum == null) {
        params["roomnum"] = _liveUid;
      } else {
        params["roomnum"] = _roomNum;
      }
      params["stream"] = _stream;
      _socket!.emit('conn', jsonEncode(params));
    } catch (e) {
      print(e);
    }
  }

  send(SocketSendModel model) {
    if (_socket != null) {
      _socket!.emit('broadcast', jsonEncode(model.create()));
    }
  }
}
