import 'package:flutter/material.dart';
import 'package:promotor_app/src/features/auth/presentation/auth_sign_in_page.dart';
import 'package:promotor_app/src/features/splash/presentation/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignInPage(),
    );
  }
}
