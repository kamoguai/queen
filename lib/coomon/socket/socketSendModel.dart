import 'dart:convert';

class SocketSendModel {
  late Map<String, dynamic> _result;
  late List<Map<String, dynamic>> _msg;
  late Map<String, dynamic> _msg0;

  SocketSendModel() {
    _result = <String, dynamic>{};
    _msg = <Map<String, dynamic>>[];
    _msg0 = <String, dynamic>{};
  }

  SocketSendModel paramS(String key, String value) {
    try {
      _msg0[key] = value;
    } catch (e) {
      print(e);
    }
    return this;
  }

  SocketSendModel paramI(String key, int value) {
    return paramS(key, value.toString());
  }

  SocketSendModel paramM(String key, Map<String, dynamic> value) {
    try {
      _msg0[key] = value;
    } catch (e) {
      print(e);
    }
    return this;
  }

  SocketSendModel paramJson(String key, String value) {
    try {
      _msg0[key] = jsonEncode(value);
    } catch (e) {
      print(e);
    }
    return this;
  }

  Map<String, dynamic> create() {
    try {
      _msg.add(_msg0);
      _result['retcode'] = '000000';
      _result['retmsg'] = 'ok';
      _result['msg'] = _msg;
    } catch (e) {
      print(e);
    }
    return _result;
  }
}
