import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:promotor_app/src/shared/models/team_model.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
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
        'team': '',
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
    await instanceAuth.signOut();
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

  @override
  Future<void> addProduct({required ProductModel productModel}) async {
    final instanceFireStore = FirebaseFirestore.instance;

    final users = instanceFireStore.collection('users');
    final teams = instanceFireStore.collection('teams');

    final docUser = users.doc(FirebaseAuth.instance.currentUser!.uid);
    final snapshotUser = await docUser.get();
    final String idTeamCurrent = snapshotUser.get('team');

    final docTeam = teams.doc(idTeamCurrent);
    final snapshotTeam = await docTeam.get();
    final teamCurrent = TeamModel.fromJson(snapshotTeam.data()!);

    teamCurrent.listProducts.add(productModel);

    await teams.doc(idTeamCurrent).update(teamCurrent.toJson());
  }

  @override
  Future<List<ProductModel>> getListProducts() async {
    final instanceFireStore = FirebaseFirestore.instance;

    final users = instanceFireStore.collection('users');
    final teams = instanceFireStore.collection('teams');

    final docUser = users.doc(FirebaseAuth.instance.currentUser!.uid);
    final snapshotUser = await docUser.get();

    final docTeam = teams.doc(snapshotUser.get('team'));
    final snapshotTeam = await docTeam.get();
    final teamCurrent = TeamModel.fromJson(snapshotTeam.data()!);

    return teamCurrent.listProducts;
  }
}
