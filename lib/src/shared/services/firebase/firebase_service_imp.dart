import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:promotor_app/src/features/team/models/team_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _throwFirebaseException(5, 'Este email já está sendo utilizado');
      }
    }
  }

  @override
  Future<void> signOut() async {
    final instanceAuth = FirebaseAuth.instance;
    instanceAuth.signOut();
  }

  @override
  Future<void> setTeam({required uidTeam}) async {
    final instanceAuth = FirebaseAuth.instance;
    final instanceFireStore = FirebaseFirestore.instance;

    User? user = instanceAuth.currentUser;
    CollectionReference users = instanceFireStore.collection('users');

    await users.doc(user!.uid).update({
      'team': uidTeam,
    });
  }

  @override
  Future<void> createTeam() async {
    final instanceFireStore = FirebaseFirestore.instance;

    User? user = FirebaseAuth.instance.currentUser;
    final teams = instanceFireStore.collection('teams');
    final users = instanceFireStore.collection('users');

    final idTeam = teams.doc().id;
    final docUser = users.doc(user!.uid);
    final snapshotUser = await docUser.get();
    final userCurrent = UserModel.fromJson(snapshotUser.data()!);

    await teams.doc(idTeam).set(
          TeamModel(
            admin: user.uid,
            title: 'Time do ${userCurrent.name}',
            listProducts: [],
          ).toJson(),
        );

    await users.doc(user.uid).update({
      'team': idTeam,
    });
  }
}
