import 'package:flutter/material.dart';
import 'package:promotor_app/src/features/home/business/home_store.dart';
import 'package:promotor_app/src/features/home/repositories/home_repository.dart';
import 'package:promotor_app/src/features/products/business/product_store.dart';
import 'package:promotor_app/src/features/products/repositories/product_repository.dart';
import 'package:promotor_app/src/features/products/services/product_service.dart';
import 'package:promotor_app/src/features/products/services/product_service_imp.dart';
import 'package:promotor_app/src/features/settings/business/settings_store.dart';
import 'package:promotor_app/src/features/settings/repositories/settings_repository.dart';
import 'package:promotor_app/src/features/team/business/team_store.dart';
import 'package:promotor_app/src/features/team/repositories/team_repository.dart';
import 'package:promotor_app/src/shared/routes/routes.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service_imp.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthStore>(create: (context) {
          final authRepository = context.read<AuthRepository>();
          return AuthStore(authRepository);
        }),
        Provider<TeamStore>(create: (context) {
          final authRepository = context.read<AuthRepository>();
          final teamRepository = context.read<TeamRepository>();
          return TeamStore(teamRepository, authRepository);
        }),
        Provider<HomeStore>(create: (context) {
          final homeRepository = context.read<HomeRepository>();
          final authRepository = context.read<AuthRepository>();
          return HomeStore(homeRepository, authRepository);
        }),
        Provider<ProductStore>(create: (context) {
          final productRepository = context.read<ProductRepository>();
          return ProductStore(productRepository);
        }),
        Provider<SettingsStore>(create: (context) {
          final settingsRepository = context.read<SettingsRepository>();
          return SettingsStore(settingsRepository);
        }),
        Provider<FirebaseService>(
          create: (context) => FirebaseServiceImp(),
        ),
        Provider<ProductService>(
          create: (context) => ProductServiceImp(),
        ),
        Provider<AuthRepository>(create: (context) {
          final firebaseService = context.read<FirebaseService>();
          return AuthRepository(firebaseService);
        }),
        Provider<TeamRepository>(create: (context) {
          final firebaseService = context.read<FirebaseService>();
          return TeamRepository(firebaseService);
        }),
        Provider<HomeRepository>(create: (context) {
          final firebaseService = context.read<FirebaseService>();
          return HomeRepository(firebaseService);
        }),
        Provider<ProductRepository>(create: (context) {
          final firebaseService = context.read<FirebaseService>();
          final productService = context.read<ProductService>();
          return ProductRepository(firebaseService, productService);
        }),
        Provider<SettingsRepository>(create: (context) {
          final firebaseService = context.read<FirebaseService>();
          return SettingsRepository(firebaseService);
        }),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          colorSchemeSeed: const Color(0xff6750a4),
          useMaterial3: true,
        ),
        routerDelegate: routes.routerDelegate,
        routeInformationParser: routes.routeInformationParser,
        routeInformationProvider: routes.routeInformationProvider,
      ),
    );
  }
}
