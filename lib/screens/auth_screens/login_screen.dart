import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tales_space/controllers/authController.dart';
import 'package:tales_space/routes.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authControllerProvider.notifier).signIn(
                      email: emailController.text,
                      password: passwordController.text,
                      context: context,
                    );
              },
              child: const Text('Login'),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                ),
                text: 'Don\'t have an account? ',
                children: <TextSpan>[
                  TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to Sign Up Screen
                          context.goNamed(GoRouterConfig.signUp);
                        }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
