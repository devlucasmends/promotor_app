import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/shared/business/navigation_store.dart';
import 'package:promotor_app/src/shared/routes/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
    );
  }
}
