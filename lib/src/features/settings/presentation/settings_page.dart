import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/settings/business/settings_state.dart';
import 'package:promotor_app/src/features/settings/business/settings_store.dart';
import 'package:promotor_app/src/features/settings/repositories/settings_repository.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late SettingsStore settingsStore;

  @override
  void initState() {
    final settingsRepository =
        Provider.of<SettingsRepository>(context, listen: false);
    settingsStore = SettingsStore(settingsRepository);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: ElevatedButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Icon(Icons.turn_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Observer(
            builder: (context) {
              if (settingsStore.state is SettingsSucessState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      settingsStore.userModel.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      settingsStore.userModel.email,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    componentEditItem(
                      nameField: 'Nome',
                      userField: settingsStore.userModel.name,
                    ),
                    componentEditItem(
                      nameField: 'Senha',
                      userField: 'Alterar Senha',
                    ),
                    componentEditItem(
                      nameField: 'Alerta Amarelo',
                      userField: '${settingsStore.userModel.yellowAlert} Dias',
                    ),
                    componentEditItem(
                      nameField: 'Alerta Vermelho',
                      userField: '${settingsStore.userModel.redAlert} Dias',
                    ),
                    const SizedBox(height: 75),
                    ElevatedButton(
                      onPressed: () {},
                      child: const SizedBox(
                        height: 50,
                        width: 120,
                        child: Center(child: Text('Salvar')),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget componentEditItem({
    required String nameField,
    required String userField,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          child: InkWell(
            onTap: () {
              if (nameField == 'Nome') {
                context.push('/home/settings/update_name');
              }
              if (nameField == 'Senha') {
                context.push('/home/settings/update_password');
              }

              if (nameField == 'Alerta Amarelo') print('Alerta Amarelo');
              if (nameField == 'Alerta Vermelho') print('Alerta Vermelho');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(nameField),
                const Spacer(),
                Text(userField),
                const Icon(Icons.arrow_right_alt_rounded),
              ],
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
