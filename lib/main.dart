import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tales_space/notification/notification_service.dart';
import 'package:tales_space/routes.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService().showNotification(message);
  log('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase first
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize notifications after Firebase
    ReceivedAction? initialAction =
        await NotificationService().initNotifications();

    // Set up Firebase Messaging handlers
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Get Firebase Messaging instance
    final messaging = FirebaseMessaging.instance;

    // Configure foreground notification options
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Request notification permissions
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Set up message handlers
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('A new onMessage event was published!');
      NotificationService().showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
    });

    // Handle initial message if app was terminated
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      await NotificationService().showNotification(initialMessage);
    }

    runApp(const ProviderScope(child: MyApp()));
  } catch (e) {
    log('Error during initialization: $e');
    rethrow;
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: const CupertinoScrollBehavior(),
      title: 'Tales Space',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      routerConfig: GoRouterConfig().goRouter,
    );
  }
}
