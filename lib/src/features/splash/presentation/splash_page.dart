import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:promotor_app/src/shared/business/auth/auth_state.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late AuthStore authStore;

  @override
  void initState() {
    super.initState();

    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    authStore = AuthStore(authRepository);
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (await authStore.userIsLogged()) {
          if (mounted) context.go('/home');
        } else {
          if (mounted) context.go('/sign_in');
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Observer(
      builder: (context) {
        if (authStore.state is AuthLoadingState) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Center(
          child: Lottie.asset('assets/animations/splash_animation.json',
              controller: _controller, onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          }),
        );
      },
    ));
  }
}
