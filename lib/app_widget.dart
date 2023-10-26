import 'package:flutter/material.dart';
import 'package:promotor_app/src/features/auth/business/auth_store.dart';
import 'package:promotor_app/src/features/auth/presentation/auth_sign_in_page.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service_imp.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MultiProvider(
          providers: [
            Provider<AuthStore>(create: (context) {
              final firebaseRepository = context.read<AuthRepository>();
              return AuthStore(firebaseRepository);
            }),
            Provider<FirebaseService>(
              create: (context) => FirebaseServiceImp(),
            ),
            Provider<AuthRepository>(create: (context) {
              final firebaseService = context.read<FirebaseService>();
              return AuthRepository(firebaseService);
            }),
          ],
          child: const SignInPage(),
        ),
      ),
    );
  }
}
