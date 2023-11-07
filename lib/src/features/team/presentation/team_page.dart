import 'package:flutter/material.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Criar Time'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Entrar em Time'),
            ),
          ],
        ),
      ),
    );
  }
}
