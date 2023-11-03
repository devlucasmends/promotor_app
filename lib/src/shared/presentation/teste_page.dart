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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
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
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          auth.login(
                              email: email.text, password: password.text);
                        },
                        child: const Text('Entrar'),
                      ),
                      const SizedBox(width: 25),
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
                      const SizedBox(width: 25),
                      ElevatedButton(
                        onPressed: () {
                          auth.createTeams();
                        },
                        child: const Text('Criar time'),
                      ),
                      const SizedBox(width: 25),
                      ElevatedButton(
                        onPressed: () {
                          auth.signOut();
                        },
                        child: const Text('Sair'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                height: 300,
                width: double.maxFinite,
                color: Colors.amber,
                child: Column(
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(text: 'Lucas'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
