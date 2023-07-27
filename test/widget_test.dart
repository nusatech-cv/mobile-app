import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pijetin/data/environment/environmet.dart';

import 'controller_test.dart';
import 'message_handler_test.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  group('FirebaseMessaging', () {
    test('processMessage should return correct message body', () {
      final messageHandler = MessageHandler();
      const notificationBody = 'Test notification body';
      const message = RemoteMessage(
        notification: RemoteNotification(
          body: notificationBody,
        ),
      );

      final result = messageHandler.processMessage(message);

      expect(result, notificationBody);
    });

    test(
        'processMessage should return default message when notification body is null',
        () {
      final messageHandler = MessageHandler();
      const defaultBody = 'No message body';
      const message = RemoteMessage(
        notification: null,
      );

      final result = messageHandler.processMessage(message);

      expect(result, defaultBody);
    });
  });

  test('BaseUrl From Env', () {
    final String baseUrl = Environment.getApiBaseUrl();
    expect(baseUrl, 'https://homespa.nusatech.id/');
  });

  test('GetX State Management', () {
    final controller = ControllerTest();
    expect(controller.name.value, 'Obelisk');

    Get.put(controller);
    expect(controller.name.value, 'Osiris');

    controller.changeName();
    expect(controller.name.value, 'Ra');

    Get.delete<ControllerTest>();

    expect(controller.name.value, '');
  });

  test('User has installed application', () {
    bool seenOnBoarding = GetStorage().read('seenOnBoarding') ?? true;
    expect(seenOnBoarding, isTrue);
  });
}
