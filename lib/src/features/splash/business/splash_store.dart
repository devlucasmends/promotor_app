import 'package:mobx/mobx.dart';
part 'splash_store.g.dart';

class SplashStore = _SplashStoreBase with _$SplashStore;

@observable
bool finish = false;

abstract class _SplashStoreBase with Store {
  // @action
  // initializeFirebase() async {
  //   await Firebase.initializeApp();
  //   finish = true;
  // }
}
