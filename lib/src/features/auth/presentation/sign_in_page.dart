import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/shared/business/auth/auth_state.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late AuthStore authStore;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();

    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    authStore = AuthStore(authRepository);

    authStore.userIsLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(
          builder: (context) {
            if (authStore.state is AuthLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      style: const TextStyle(color: Colors.amber),
                      decoration: const InputDecoration(labelText: "Email"),
                      controller: email,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      style: const TextStyle(color: Colors.amber),
                      decoration: const InputDecoration(labelText: "Senha"),
                      controller: password,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await authStore
                            .signIn(email: email.text, password: password.text)
                            .whenComplete(() {
                          if (authStore.state is AuthSucessState) {
                            if (authStore.userModel!.team == '' ||
                                authStore.userModel!.team.isEmpty) {
                              if (context.mounted) context.go('/team');
                            } else {
                              if (context.mounted) context.go('/home');
                            }
                          }
                        });
                      },
                      child: const Text('Entrar'),
                    ),
                    const SizedBox(width: 25),
                    ElevatedButton(
                      onPressed: () {
                        context.go('/sign_in/sign_up');
                      },
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
