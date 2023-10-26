import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';
import 'package:promotor_app/src/shared/exceptions/firebase_exception.dart'
    as fe;

class FirebaseServiceImp implements FirebaseService {
  FirebaseServiceImp() {
    initialize();
  }

  void _throwFirebaseException(int statusCode, String message) {
    throw fe.FirebaseException(statusCode, message);
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final instance = FirebaseAuth.instance;

      await instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _throwFirebaseException(1, 'Email invalido');
      } else if (e.code == 'user-disabled') {
        _throwFirebaseException(2, 'Usuário desabilitado');
      } else if (e.code == 'user-not-found') {
        _throwFirebaseException(3, 'Usuário não cadastrado');
      } else if (e.code == 'wrong-password') {
        _throwFirebaseException(4, 'Senha Incorreta');
      }
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final instanceAuth = FirebaseAuth.instance;
      final instanceFireStore = FirebaseFirestore.instance;

      await instanceAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = instanceAuth.currentUser;
      CollectionReference users = instanceFireStore.collection('users');

      await users.doc(user!.uid).set({
        'name': name,
        'phone': phone,
        'email': email,
        'uid': user.uid,
      });

      // TODO: I stopped here, check if all the necessary parameters are declared and deal with excesses
    } catch (e) {}
  }
}
