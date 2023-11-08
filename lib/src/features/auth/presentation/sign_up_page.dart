import 'package:flutter/material.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:provider/provider.dart';

import '../../../shared/repositories/auth/auth_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late AuthStore auth;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
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
      // appBar: AppBar(
      //   leading: BackButton(
      //     onPressed: () {
      //       print('object');
      //     },
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: const TextStyle(color: Colors.amber),
              decoration: const InputDecoration(labelText: "Nome"),
              controller: name,
            ),
            const SizedBox(height: 20),
            TextField(
              style: const TextStyle(color: Colors.amber),
              decoration: const InputDecoration(labelText: "Telefone"),
              controller: phone,
            ),
            const SizedBox(height: 20),
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
                auth.signUp(
                  name: name.text,
                  phone: phone.text,
                  email: email.text,
                  password: password.text,
                );
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
