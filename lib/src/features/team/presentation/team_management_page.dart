import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/team/business/team_state.dart';
import 'package:promotor_app/src/features/team/business/team_store.dart';
import 'package:promotor_app/src/features/team/repositories/team_repository.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:provider/provider.dart';

class TeamManagementPage extends StatefulWidget {
  const TeamManagementPage({super.key});

  @override
  State<TeamManagementPage> createState() => _TeamManagementPageState();
}

class _TeamManagementPageState extends State<TeamManagementPage> {
  late TeamStore teamStore;
  late AuthStore authStore;
  @override
  void initState() {
    final teamRepository = Provider.of<TeamRepository>(context, listen: false);
    teamStore = TeamStore(teamRepository);

    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    authStore = AuthStore(authRepository);

    teamStore.getTeamCurrent();
    authStore.userIsLogged();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Observer(
          builder: (context) {
            if (teamStore.state is TeamLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              if (teamStore.teamCurrent!.admin == authStore.userModel!.uid) {
                return ListView.separated(
                  itemCount: teamStore.teamCurrent!.listUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(teamStore.teamCurrent!.listUsers[index].name),
                      subtitle:
                          Text(teamStore.teamCurrent!.listUsers[index].email),
                      trailing: (teamStore.teamCurrent?.listUsers[index].uid !=
                              teamStore.teamCurrent!.admin)
                          ? IconButton(
                              iconSize: 30,
                              color: Colors.red,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Você confirma a exclusão deste usuário do time?",
                                      ),
                                      content: const Text(
                                          'Após esta ação, ele não terá mais acesso à lista de produtos.'),
                                      actions: [
                                        TextButton(
                                            child: const Text("Cancelar"),
                                            onPressed: () => context.pop()),
                                        TextButton(
                                          child: const Text("Confirmar"),
                                          onPressed: () async {
                                            await teamStore
                                                .removeUserTeam(
                                              uidTeam: teamStore.teamCurrent!
                                                  .listUsers[index].team,
                                              uidUser: teamStore.teamCurrent!
                                                  .listUsers[index].uid,
                                              index: index,
                                            )
                                                .whenComplete(
                                              () async {
                                                context.pop();
                                                await teamStore
                                                    .getTeamCurrent();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon:
                                  const Icon(Icons.remove_circle_outline_sharp),
                            )
                          : const Text(
                              'Admin',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                );
              } else {
                return ListView.separated(
                  itemCount: teamStore.teamCurrent!.listUsers.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(teamStore.teamCurrent!.listUsers[index].name),
                      subtitle:
                          Text(teamStore.teamCurrent!.listUsers[index].email),
                      trailing: (teamStore.teamCurrent?.listUsers[index].uid ==
                              teamStore.teamCurrent!.admin)
                          ? const Text(
                              'Admin',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          : null,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
