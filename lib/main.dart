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
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  log('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotifications();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('A new onMessage event was published!');
    NotificationService().showNotification(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('A new onMessageOpenedApp event was published!');
  });
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? message) async {
    if (message != null) {
      await NotificationService().showNotification(message);
    }
  });
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    // updateUser();
  }

  // updateUser() async {
  //   // UtilMethods().getPermission();
  //
  //   try {
  //     User account = await ref.read(appwriteAccountProvider).get();
  //     if (account.$id.isNotEmpty) {
  //       final token = await FirebaseMessaging.instance.getToken();
  //       log(token.toString());
  //       UserModel? user = await ref.read(currentUserProvider.future);
  //       // Position position = await UtilMethods().getCurrentLatLong();
  //       // log(position.toString());
  //       log('${user?.username}');
  //       if (user != null) {
  //         UserModel userModel = UserModel(
  //             bio: user.bio,
  //             email: user.email,
  //             username: user.username,
  //             profileImage: user.profileImage,
  //             userid: user.userid,
  //             isSeller: user.isSeller,
  //             fcmToken: token ?? '',
  //             lat: "position.latitude.toString()",
  //             long: "position.longitude.toString()");
  //         ref.read(authControllerProvider.notifier).updateUser(userModel);
  //       }
  //     }
  //   } catch (e) {
  //     Constants.logger.e(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: const CupertinoScrollBehavior(),
      title: 'Buk Cuk',
      theme: ThemeData.dark(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouterConfig().goRouter,
    );
  }
}
