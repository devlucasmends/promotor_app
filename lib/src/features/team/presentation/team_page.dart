import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/team/business/team_state.dart';
import 'package:promotor_app/src/features/team/business/team_store.dart';
import 'package:promotor_app/src/features/team/repositories/team_repository.dart';
import 'package:provider/provider.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late TeamStore team;
  TextEditingController uidTeam = TextEditingController();

  @override
  void initState() {
    super.initState();
    final teamRepository = Provider.of<TeamRepository>(context, listen: false);
    team = TeamStore(teamRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(
          builder: (context) {
            if (team.state is TeamLoadingState) {
              return const CircularProgressIndicator.adaptive();
            } else {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      style: const TextStyle(color: Colors.amber),
                      decoration:
                          const InputDecoration(labelText: "ID do Time"),
                      controller: uidTeam,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await team.createTeam();
                        if (team.state is TeamSucessState) {
                          if (context.mounted) context.go('/home');
                        }
                      },
                      child: const Text('Criar Time'),
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () async {
                        await team.setTeam(uidTeam: uidTeam.text);
                        if (team.state is TeamSucessState) {
                          if (context.mounted) context.go('/home');
                        }
                      },
                      child: const Text('Entrar em Time'),
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
