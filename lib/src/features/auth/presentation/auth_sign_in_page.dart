import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            style: TextStyle(color: Colors.amber),
            decoration: InputDecoration(labelText: "Email"),
          ),
          const SizedBox(height: 20),
          const TextField(
            style: TextStyle(color: Colors.amber),
            decoration: InputDecoration(labelText: "Senha"),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Entrar'),
          ),
        ],
      ),
    );
  }
}
