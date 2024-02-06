import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/team/business/team_state.dart';
import 'package:promotor_app/src/features/team/business/team_store.dart';
import 'package:promotor_app/src/features/team/repositories/team_repository.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:provider/provider.dart';

class TeamManagementPage extends StatefulWidget {
  const TeamManagementPage({super.key});

  @override
  State<TeamManagementPage> createState() => _TeamManagementPageState();
}

class _TeamManagementPageState extends State<TeamManagementPage> {
  late TeamStore teamStore;

  @override
  void initState() {
    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    final teamRepository = Provider.of<TeamRepository>(context, listen: false);
    teamStore = TeamStore(teamRepository, authRepository);

    teamStore.getTeamCurrent();

    super.initState();
  }

  void showSnackBar({required Color? color, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 3),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        behavior: SnackBarBehavior.floating,
        content: Text(message, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time'),
        actions: [
          IconButton(
              onPressed: () {
                if (teamStore.teamCurrent!.admin == teamStore.userModel!.uid) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actionsPadding: const EdgeInsets.only(bottom: 25),
                      title: const Text('Codigo Acesso do Time'),
                      content: const Text(
                        'Selecione o código e envie para o novo membro.',
                      ),
                      actions: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SelectableText(
                              teamStore.teamCurrent!.uid,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                      actionsAlignment: MainAxisAlignment.center,
                    ),
                  );
                } else {
                  showSnackBar(
                      color: Colors.red[300],
                      message:
                          'Sem permissão para convidar. Contate o Administrador.');
                }
              },
              icon: const Icon(Icons.group_add_rounded))
        ],
      ),
      body: Center(
        child: Observer(
          builder: (context) {
            if (teamStore.state is TeamFailureState) {
              final errorMessage =
                  (teamStore.state as TeamFailureState).errorMessage;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackBar(color: Colors.red[300], message: errorMessage);
              });
            }
            if (teamStore.state is TeamLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              if (teamStore.teamCurrent!.admin == teamStore.userModel!.uid) {
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
