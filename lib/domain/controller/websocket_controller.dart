import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:pijetin/domain/controller/user_controller/user_controller.dart';
import 'package:web_socket_channel/io.dart';
import '../../config/network/request_header.dart';
import '../../data/data.dart';

class Websocket {
  late IOWebSocketChannel channel;
  StreamController streamController = StreamController();
  final String? _baseUrl = Environment.getWSBaseUrl();
  var websocketConected = false;
  bool loading = false;
  bool timeout = false;
  static final Websocket instance = Websocket();
  late UserController userController;
  String uidData = '';

  void onInit() async {
    userController = Get.put(UserController());
    await userController.getUser();
    streamController = StreamController.broadcast();
    connectToWebSocket();
  }

  void connectToWebSocket() async {
    RequestHeaders headers = RequestHeaders();
    final String wsURL = '$_baseUrl/?stream=orders';
    log(wsURL);
    channel =
        IOWebSocketChannel.connect(wsURL, headers: headers.setAuthHeaders());
    channel.stream.listen((event) {
      streamController.add(event);
      log("event Stream ws===>");
      log(event.toString());
    }, onError: (e) async {
      await Future.delayed(const Duration(seconds: 3));
      connectToWebSocket();
    }, onDone: () async {
      await Future.delayed(const Duration(seconds: 3));
      connectToWebSocket();
    }, cancelOnError: true);
  }

  Future<void> subscribeOrderDetail(String uid) async {
    uidData = uid;
    channel.sink.add(json.encode({
      "event": "subscribe",
      "streams": [uid]
    }));
    log(channel.stream.toString());
  }

  Future<void> unSubscribeOrder(String uid) async {
    uidData = uid;
    channel.sink.add(json.encode({
      "event": "unsubscribe",
      "streams": [uid]
    }));
  }

  void onClose() {
    channel.sink.close();
  }
}
