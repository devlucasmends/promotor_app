import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/settings/business/settings_state.dart';
import 'package:promotor_app/src/features/settings/business/settings_store.dart';
import 'package:promotor_app/src/features/settings/repositories/settings_repository.dart';
import 'package:promotor_app/src/shared/extensions/validate_extension.dart';
import 'package:provider/provider.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  late SettingsStore settingsStore;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final settingsRepository =
        Provider.of<SettingsRepository>(context, listen: false);
    settingsStore = SettingsStore(settingsRepository);
    settingsStore.state = SettingsInitState();

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
        title: const Text('Atualizar Dados'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 100.0),
        child: Observer(
          builder: (context) {
            if (settingsStore.state is SettingsFailureState) {
              final errorMessage =
                  (settingsStore.state as SettingsFailureState).errorMessage;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                showSnackBar(color: Colors.red[300], message: errorMessage);
              });
            }
            if (settingsStore.state is SettingsLoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      componentPasswordWidget(
                        label: 'Senha Antiga',
                        hintText: '******',
                        controller: oldPasswordController,
                      ),
                      const SizedBox(height: 20),
                      componentPasswordWidget(
                        label: 'Nova Senha',
                        controller: newPasswordController,
                      ),
                      const SizedBox(height: 20),
                      componentPasswordWidget(
                        label: 'Confirme Nova Senha',
                        controller: confirmNewPasswordController,
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
                            onPressed: () {
                              context.pop();
                            },
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
                            onPressed: () async {
                              if (newPasswordController.text ==
                                  confirmNewPasswordController.text) {
                                if (oldPasswordController.text !=
                                    newPasswordController.text) {
                                  if (formKey.currentState!.validate()) {
                                    await settingsStore
                                        .updatePassword(
                                      oldPassword: oldPasswordController.text,
                                      newPassword: newPasswordController.text,
                                    )
                                        .whenComplete(() {
                                      if (settingsStore.updateSucess) {
                                        showSnackBar(
                                            color: Colors.green[300],
                                            message:
                                                'Senha atualizada com sucesso!');
                                        context.pop();
                                      }
                                    });
                                  }
                                } else {
                                  showSnackBar(
                                    color: Colors.red[300],
                                    message:
                                        'Senha antiga e Nova senha estão iguais.',
                                  );
                                }
                              } else {
                                showSnackBar(
                                  color: Colors.red[300],
                                  message:
                                      'Campos \'Nova Senha\' e \'Confirmar Nova Senha\' não estão iguais.',
                                );
                              }
                            },
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
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget componentPasswordWidget({
    required String label,
    String? hintText,
    required TextEditingController controller,
  }) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            controller: controller,
            validator: (value) => value?.validatePassword(),
            obscureText: true,
          ),
        ),
      ],
    );
  }
}
