import 'package:flutter/material.dart';
import 'package:promotor_app/src/features/auth/business/auth_store.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late AuthStore auth;
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  void initState() {
    super.initState();

    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    auth = AuthStore(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(labelText: "Email"),
            controller: nome,
          ),
          const SizedBox(height: 20),
          TextField(
            style: const TextStyle(color: Colors.amber),
            decoration: const InputDecoration(labelText: "Senha"),
            controller: senha,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              auth.login(nome: nome.text, senha: senha.text);
            },
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
