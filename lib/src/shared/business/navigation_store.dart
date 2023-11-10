import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

part 'navigation_store.g.dart';

class NavigationStore = NavigationStoreBase with _$NavigationStore;

abstract class NavigationStoreBase with Store {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigate({required String routeName, required context}) async {
    navigatorKey.currentContext!.go(routeName);
    // return navigatorKey.currentState!.pushNamed(routeName);
  }
}
