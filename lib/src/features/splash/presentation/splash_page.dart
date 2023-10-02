import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xff1B232A),
      child: Stack(
        children: [
          Image.asset('assets/images/mask_splash.png'),
          Center(
            child: Image.asset('assets/icons/logo.png'),
          ),
        ],
      ),
    );
  }
}
