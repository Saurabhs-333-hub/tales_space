import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tales_space/screens/auth_screens/auth_wrapper.dart';
import 'package:tales_space/screens/auth_screens/login_screen.dart';
import 'package:tales_space/screens/auth_screens/signup_screen.dart';
import 'package:tales_space/screens/main_wrapper.dart';

import 'constants/constants.dart';

class GoRouterConfig {
  static const String initial = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String userProfile = '/user-profile';
  static const String settings = '/settings';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String help = '/help';
  static const String terms = '/terms';
  static const String privacy = '/privacy';
  static const String faq = '/faq';
  static const String feedback = '/feedback';
  static const String notifications = '/notifications';
  static const String messages = '/messages';
  static const String chat = '/chat';
  static const String search = '/search';
  static const String users = '/users';
  static const String user = '/user';
  static const String posts = '/posts';
  static const String post = '/post';
  static const String createPost = '/create-post';
  static const String editPost = '/edit-post';
  static const String comments = '/comments';
  static const String comment = '/comment';
  static const String createComment = '/create-comment';
  static const String editComment = '/edit-comment';
  static const String likes = '/likes';
  static const String like = '/like';
  static const String createLike = '/create-like';
  static const String editLike = '/edit-like';
  static const String follow = '/follow';
  static const String unfollow = '/unfollow';
  static const String block = '/block';
  static const String unblock = '/unblock';
  static const String report = '/report';
  static const String reportPost = '/report-post';
  static const String reportComment = '/report-comment';
  static const String reportUser = '/report-user';
  static const String reportFeedback = '/report-feedback';
  static const String reportMessage = '/report-message';
  static const String reportChat = '/report-chat';
  static const String reportLike = '/report-like';
  static const String reportFollow = '/report-follow';
  static const String reportBlock = '/report-block';
  static const String reportUnblock = '/report-unblock';
  static const String reportTerms = '/report-terms';
  static const String reportPrivacy = '/report-privacy';
  static const String reportFaq = '/report-faq';
  static const String reportHelp = '/report-help';
  static const String reportContact = '/report-contact';

  GoRouter goRouter = GoRouter(
    navigatorKey: Constants.navigatorKey,
    routes: [
      GoRoute(
          path: GoRouterConfig.initial,
          pageBuilder: (context, state) => MaterialPage(child: AuthWrapper()),
          name: '/',
          routes: []),
      GoRoute(
        path: GoRouterConfig.home,
        pageBuilder: (context, state) => MaterialPage(child: MainWrapper()),
        name: GoRouterConfig.home,
      ),
      GoRoute(
          path: GoRouterConfig.login,
          pageBuilder: (context, state) => MaterialPage(child: LoginScreen()),
          name: GoRouterConfig.login,
          routes: []),
      GoRoute(
          path: GoRouterConfig.signUp,
          pageBuilder: (context, state) => MaterialPage(child: SignUpScreen()),
          name: GoRouterConfig.signUp,
          routes: []),
    ],
  );
}
