import 'package:firebase_core/firebase_core.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class FirebaseServiceImp implements FirebaseService {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}
