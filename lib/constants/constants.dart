
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
export './constants.dart';

class Constants {
  static const String appName = 'Flutter Firebase';
  static const String home = 'Home';
  static const String settings = 'Settings';
  static const String signOut = 'Sign out';

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> thoughtsNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> reelsNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> exploreNavigatorKey = GlobalKey<NavigatorState>();
static Logger logger = Logger();

  static const List<String> choices = <String>[
    home,
    settings,
    signOut,
  ];
}

