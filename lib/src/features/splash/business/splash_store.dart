import 'package:mobx/mobx.dart';
part 'splash_store.g.dart';

class SplashStore = SplashStoreBase with _$SplashStore;

@observable
bool finish = false;

abstract class SplashStoreBase with Store {}
