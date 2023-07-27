import 'package:firebase_messaging/firebase_messaging.dart';

class MessageHandler {
  String processMessage(RemoteMessage message) {
    return message.notification?.body ?? 'No message body';
  }
}
