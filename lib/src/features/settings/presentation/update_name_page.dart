import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:promotor_app/src/features/settings/business/settings_state.dart';
import 'package:promotor_app/src/features/settings/business/settings_store.dart';
import 'package:promotor_app/src/features/settings/repositories/settings_repository.dart';
import 'package:provider/provider.dart';

class UpdateNamePage extends StatefulWidget {
  const UpdateNamePage({super.key});

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
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
      appBar: AppBar(
        title: const Text('Atualizar Dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Observer(
          builder: (context) {
            if (settingsStore.state is SettingsLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const ClipOval(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.account_circle,
                            size: 150,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nome',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: settingsStore.userModel.name,
                          hintStyle: const TextStyle(fontSize: 18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: Colors.grey.shade700,
                          ),
                          onPressed: () {},
                          child: const SizedBox(
                            height: 45,
                            width: 100,
                            child: Center(child: Text('Cancelar')),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {},
                          child: const SizedBox(
                            height: 45,
                            width: 100,
                            child: Center(child: Text('Salvar')),
                          ),
                        ),
                      ],
                    )
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
