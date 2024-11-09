import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tales_space/controllers/authController.dart';
import 'package:tales_space/screens/main_wrapper.dart';

import 'login_screen.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  bool isEmailVerified = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppLifecycleListener(onResume: () async {
      bool isVerified =
          await ref.read(authControllerProvider.notifier).checkEmailVerified();
      setState(() {
        isEmailVerified = isVerified;
      });
    }, onRestart: () async {
      bool isVerified =
          await ref.read(authControllerProvider.notifier).checkEmailVerified();
      setState(() {
        isEmailVerified = isVerified;
      });
    }, onInactive: () async {
      bool isVerified =
          await ref.read(authControllerProvider.notifier).checkEmailVerified();
      setState(() {
        isEmailVerified = isVerified;
      });
    }, onStateChange: (state) async {
      bool isVerified =
          await ref.read(authControllerProvider.notifier).checkEmailVerified();
      setState(() {
        isEmailVerified = isVerified;
      });
      log('State changed to $state');
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          if (isEmailVerified) {
            return const MainWrapper();
          }
          return const Scaffold(
            body: Center(
              child: Text('Please verify your email'),
            ),
          );
        }
        return const LoginScreen();
      },
    );
  }
}
