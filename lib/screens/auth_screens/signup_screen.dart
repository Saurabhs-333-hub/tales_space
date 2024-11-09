import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tales_space/controllers/authController.dart';
import 'package:tales_space/routes.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
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
                ref.read(authControllerProvider.notifier).signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      context: context,
                      name: nameController.text.trim(),
                    );
              },
              child: const Text('Sign Up'),
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                ),
                text: 'Already have an account? ',
                children: <TextSpan>[
                  TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Navigate to Login Screen
                          context.goNamed(GoRouterConfig.login);
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
