import 'package:flutter/material.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late AuthStore auth;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();

    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    auth = AuthStore(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
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
                onPressed: () {
                  auth.signIn(email: email.text, password: password.text);
                },
                child: const Text('Entrar'),
              ),
              const SizedBox(width: 25),
              ElevatedButton(
                onPressed: () {
                  auth.signIn(email: email.text, password: password.text);
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
