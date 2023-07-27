// ignore_for_file: unused_element

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pijetin/view/pages/auth/Onboarding/splash_page.dart';

import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());

  await GetStorage.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    initLocalNotif();
    registerNotification();
    super.initState();
  }

  void registerNotification() async {
    //...
    // await FirebaseMessaging.instance.subscribeToTopic("private");

    var token = await FirebaseMessaging.instance.getToken();
    log("token $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // ...

      _showNotification(
          message.notification!.title!, message.notification!.body!);
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   print("on open app : ${event.collapseKey}");
    // });
  }

  initLocalNotif() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
    // var android = const AndroidInitializationSettings('ic_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id', 'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
        enableLights: true,
        ledColor: Colors.green,
        ledOffMs: 1,
        ledOnMs: 1,
        icon: "mipmap/ic_launcher");
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'custom_payload',
    );
  }

  Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    log("Handling a background message: ${message.messageId}");
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Builder(builder: (context) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Home Spa',
              theme: Styles.themeData(false, context),
              home: SplashScreen(),
            );
          });
        });
  }
}
