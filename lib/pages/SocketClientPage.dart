import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:queen/widgets/BaseWidget.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

class SocketClientPage extends StatefulWidget {
  const SocketClientPage({super.key});

  @override
  State<SocketClientPage> createState() => _SocketClientPageState();
}

class _SocketClientPageState extends State<SocketClientPage> with BaseWidget {
  var _isOnConnect = false;
  final _messageList = <String>[];
  final _userName = "flutter_clinet";
  final _room = "a";
  RTCPeerConnection? _peerConnection;
  bool _inCallling = false;
  RTCDataChannelInit? _dataChannelDict;
  RTCDataChannel? _dataChannel;
  String _sdp = '';

  late io.Socket socket;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    connectSokcetIO();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: () {
          final stateString = _isOnConnect ? "已連線" : "未連線";
          return Text('聊天室 狀態: $stateString');
        }(),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.call))],
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Column(children: [
          Expanded(child: _buildMessageListView()),
          _buildTextFieldRow(),
        ]),
      ),
    );
  }

  Widget _buildMessageListView() {
    return Container(
      color: Colors.grey.shade300,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _messageList.length,
        itemBuilder: (BuildContext context, int index) {
          final content = _messageList[index];
          return Text(content, style: TextStyle(fontSize: 20));
        },
      ),
    );
  }

  Widget _buildTextFieldRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _textEditingController,
              style:
                  TextStyle(fontSize: 15.0, height: 1.5, color: Colors.black),
              decoration: InputDecoration(
                hintText: '請輸入訊息',
                hintStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.transparent,
                filled: true,
                isDense: true,
                contentPadding: const EdgeInsets.fromLTRB(18, 14, 0, 14),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            height: 52,
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.blue,
              child: Icon(Icons.send),
              onPressed: () {
                sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }

  sendMessage() {
    final sendData = '$_userName:${_textEditingController.text}';
    socket.emit('message', [_room, sendData]);
    _textEditingController.text = '';
  }

  connectSokcetIO() {
    // socket = io.io('ws://192.168.235.168:8080', <String, dynamic>{
    //   'transports': ['websocket']
    // });
    socket = io.io(
        'ws://192.168.235.168:8080',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());

    socket.onConnect((_) {
      print('on connect');
      // socket.emit('msg', 'test');
      _isOnConnect = true;
      socket.on('joined', (data) {
        print('joined');
        //room, id
        print(data.runtimeType);
        print(data);
      });
    });

    socket.on('message', (data) {
      print('message: ${data[1]}');
      // print(data.runtimeType);
      // print(data);

      final messageContent = data[1];
      _messageList.add(messageContent);
    });

    socket.onDisconnect((data) {
      print('disconnect');
      print(data);
    });

    socket.onConnectError((data) {
      print(data);
    });

    socket.emit('join', _room);
  }

  _onSignalingState(RTCSignalingState state) {
    print(state);
  }

  _onIceGatheringState(RTCIceGatheringState state) {
    print(state);
  }

  _onIceConnectionState(RTCIceConnectionState state) {
    print(state);
  }

  _onCandidate(RTCIceCandidate candidate) {
    print('onCandidate: ${candidate.candidate}');
    _peerConnection?.addCandidate(candidate);
    // setState(() {
    _sdp += '\n';
    _sdp += candidate.candidate ?? '';
    print('onCandidate: update sdp');
    print(_sdp);
    // });
  }

  _onRenegotiationNeeded() {
    print('RenegotiationNeeded');
  }

  /// Send some sample messages and handle incoming messages.
  _onDataChannel(RTCDataChannel dataChannel) {
    dataChannel.onMessage = (message) {
      if (message.type == MessageType.text) {
        print(message.text);
      } else {
        // do something with message.binary
      }
    };
    // or alternatively:
    dataChannel.messageStream.listen((message) {
      if (message.type == MessageType.text) {
        print(message.text);
      } else {
        // do something with message.binary
      }
    });

    dataChannel.send(RTCDataChannelMessage('Hello!'));
    dataChannel.send(RTCDataChannelMessage.fromBinary(Uint8List(5)));
  }

  void makeCall() async {
    var configuration = <String, dynamic>{
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ]
    };

    final offerSdpConstraints = <String, dynamic>{
      'mandatory': {
        'OfferToReceiveAudio': false,
        'OfferToReceiveVideo': false,
      },
      'optional': [],
    };

    final loopbackConstraints = <String, dynamic>{
      'mandatory': {},
      'optional': [
        {'DtlsSrtpKeyAgreement': true},
      ],
    };

    if (_peerConnection != null) return;

    try {
      _peerConnection =
          await createPeerConnection(configuration, loopbackConstraints);

      _peerConnection?.onSignalingState = _onSignalingState;
      _peerConnection?.onIceGatheringState = _onIceGatheringState;
      _peerConnection?.onIceConnectionState = _onIceConnectionState;
      // _peerConnection?.onIceCandidate = _onCandidate;
      _peerConnection?.onRenegotiationNeeded = _onRenegotiationNeeded;

      _dataChannelDict = RTCDataChannelInit();
      _dataChannelDict?.id = 1;
      _dataChannelDict?.ordered = true;
      _dataChannelDict?.maxRetransmitTime = -1;
      _dataChannelDict?.maxRetransmits = -1;
      _dataChannelDict?.protocol = 'sctp';
      _dataChannelDict?.negotiated = false;

      _dataChannel = await _peerConnection!
          .createDataChannel('dataChannel', _dataChannelDict!);
      _peerConnection?.onDataChannel = _onDataChannel;

      var description = await _peerConnection!.createOffer(offerSdpConstraints);
      print(description.sdp);
      //設定本地的SDP
      await _peerConnection?.setLocalDescription(description);

      _sdp = description.sdp ?? '';
      // print("sdp:");
      // print(_sdp);

      /* 
      "v=0
      o=- 7952352823390211101 2 IN IP4 127.0.0.1
      s=-
      t=0 0
      a=group:BUNDLE data
      a=extmap-allow-mixed
      a=msid-semantic: WMS
      m=application 9 UDP/DTLS/SCTP webrtc-datachannel
      c=IN IP4 0.0.0.0
      a=ice-ufrag:fEwz
      a=ice-pwd:jpAbq2rex2K3J4wvoGAjK23D
      a=ice-options:trickle renomination
      a=fingerprint:sha-256 A4:9C:7B:0C:D4:84:CE:1B:48:2C:5F:0D:63:88:4B:B5:C7:B0:43:E9:3F:20:13:5F:D8:AB:38:1D:FC:AD:EE:DF
      a=setup:actpass
      a=mid:data
      a=sctp-port:5000
      a=max-message-size:262144
      "
      */

      //change for loopback.
      //description.type = 'answer';
      //_peerConnection.setRemoteDescription(description);
    } catch (e) {
      print(e.toString());
    }
    // if (!mounted) return;

    // setState(() {
    //   _inCalling = true;
    // });
  }
}
