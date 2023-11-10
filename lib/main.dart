import 'package:flutter/material.dart';
import 'package:promotor_app/app_widget.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/business/navigation_store.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service_imp.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider<NavigationStore>(
          create: (context) => NavigationStore(),
        ),
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
      child: const AppWidget(),
    ),
  );
}
