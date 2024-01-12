import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:promotor_app/src/shared/business/auth/auth_state.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/extensions/validate_extension.dart';
import 'package:provider/provider.dart';

import '../../../shared/repositories/auth/auth_repository.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late AuthStore authStore;
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    authStore = AuthStore(authRepository);
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
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Observer(
        builder: (context) {
          if (authStore.state is AuthFailureState) {
            final errorMessage =
                (authStore.state as AuthFailureState).errorMessage;

            WidgetsBinding.instance.addPostFrameCallback((_) {
              showSnackBar(color: Colors.red[300], message: errorMessage);
            });
          }
          if (authStore.state is AuthSucessState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) context.go('/team');
            });
          }
          if (authStore.state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.amber),
                        decoration: const InputDecoration(labelText: "Nome"),
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.amber),
                        decoration:
                            const InputDecoration(labelText: "Telefone"),
                        controller: phone,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: "(##) #####-####",
                            filter: {"#": RegExp('[0-9]')},
                            type: MaskAutoCompletionType.eager,
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.amber),
                        decoration: const InputDecoration(labelText: "Email"),
                        controller: email,
                        validator: (value) => value?.validateEmail(),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        style: const TextStyle(color: Colors.amber),
                        decoration: const InputDecoration(labelText: "Senha"),
                        controller: password,
                        validator: (value) => value?.validatePassword(),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await authStore.signUp(
                              name: name.text,
                              phone: phone.text,
                              email: email.text,
                              password: password.text,
                            );
                          }
                        },
                        child: const Text('Cadastrar'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
