import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:promotor_app/src/shared/models/team_model.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';
import 'package:promotor_app/src/shared/exceptions/firebase_exception.dart'
    as fe;

class FirebaseServiceImp implements FirebaseService {
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
  Future<void> addUserListTeam({required uidTeam}) async {
    final instanceFireStore = FirebaseFirestore.instance;

    final users = instanceFireStore.collection('users');
    final teams = instanceFireStore.collection('teams');

    final docTeam = teams.doc(uidTeam);
    final snapshotTeam = await docTeam.get();
    final teamCurrent = TeamModel.fromJson(snapshotTeam.data()!);

    final docUser = users.doc(FirebaseAuth.instance.currentUser!.uid);
    final snapShotUser = await docUser.get();

    teamCurrent.listUsers.add(UserModel.fromJson(snapShotUser.data()!));

    await teams.doc(uidTeam).update(teamCurrent.toJson());
  }

  @override
  Future<void> setTeam({required uidTeam}) async {
    final instanceFireStore = FirebaseFirestore.instance;

    final users = instanceFireStore.collection('users');
    User? user = FirebaseAuth.instance.currentUser;

    await users.doc(user!.uid).update({
      'team': uidTeam,
    });

    await addUserListTeam(uidTeam: uidTeam);
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
            uid: idTeam,
            title: 'Time do ${userCurrent.name}',
            listProducts: [],
            listUsers: [],
          ).toJson(),
        );

    await users.doc(user.uid).update({
      'team': idTeam,
    });

    await addUserListTeam(uidTeam: idTeam);
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

    teamCurrent.listProducts.sort((a, b) {
      var dateA = DateTime.parse(a.validate.split('/').reversed.join());
      var dateB = DateTime.parse(b.validate.split('/').reversed.join());
      return dateA.compareTo(dateB);
    });

    await teams.doc(idTeamCurrent).update(teamCurrent.toJson());
  }

  @override
  Future<TeamModel> getTeamCurrent() async {
    final instanceFireStore = FirebaseFirestore.instance;

    final users = instanceFireStore.collection('users');
    final teams = instanceFireStore.collection('teams');

    final docUser = users.doc(FirebaseAuth.instance.currentUser!.uid);
    final snapshotUser = await docUser.get();

    final docTeam = teams.doc(snapshotUser.get('team'));
    final snapshotTeam = await docTeam.get();
    final teamCurrent = TeamModel.fromJson(snapshotTeam.data()!);
    return teamCurrent;
  }

  @override
  Future<void> editProduct({
    required ProductModel product,
    required int index,
    required String idTeamCurrent,
  }) async {
    final instanceFireStore = FirebaseFirestore.instance;

    final teams = instanceFireStore.collection('teams');

    final docTeam = teams.doc(idTeamCurrent);
    final snapshotTeam = await docTeam.get();
    final teamCurrent = TeamModel.fromJson(snapshotTeam.data()!);

    teamCurrent.listProducts[index] = product;

    teamCurrent.listProducts.sort((a, b) {
      var dateA = DateTime.parse(a.validate.split('/').reversed.join());
      var dateB = DateTime.parse(b.validate.split('/').reversed.join());
      return dateA.compareTo(dateB);
    });

    docTeam.update(teamCurrent.toJson());
  }

  @override
  Future<String> addImageStorage({
    required String path,
    required String identifier,
    required UserModel user,
  }) async {
    final storage = FirebaseStorage.instance;
    String reference;

    File file = File(path);

    try {
      reference = '${user.team}/img-$identifier.jpg';

      await storage.ref(reference).putFile(file);

      return await storage.ref(reference).getDownloadURL();
    } catch (e) {
      _throwFirebaseException(0, 'Erro Inesperado. Tente novamente...');
    }
    return '';
  }

  @override
  Future<UserModel?> userLogged() async {
    try {
      final instance = FirebaseAuth.instance;
      User? user = instance.currentUser;
      UserModel? userModel;

      if (user != null) {
        final docUser =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        final snapshot = await docUser.get();
        userModel = UserModel.fromJson(snapshot.data()!);
      }
      return userModel;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<void> removeUserTeam({
    required String uidTeam,
    required String uidUser,
    required int index,
  }) async {
    final instanceFireStore = FirebaseFirestore.instance;

    final users = instanceFireStore.collection('users');
    final teams = instanceFireStore.collection('teams');

    final docTeam = teams.doc(uidTeam);
    final snapshotTeam = await docTeam.get();
    final teamCurrent = TeamModel.fromJson(snapshotTeam.data()!);

    await users.doc(uidUser).update({
      'team': '',
    });

    teamCurrent.listUsers.removeAt(index);
    await teams.doc(uidTeam).update(teamCurrent.toJson());
  }

  @override
  Future<void> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final user = FirebaseAuth.instance;
      final credential = EmailAuthProvider.credential(
          email: user.currentUser!.email!, password: oldPassword);
      await user.currentUser?.reauthenticateWithCredential(credential);
      await user.currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _throwFirebaseException(5, 'Este email já está sendo utilizado');
      } else if (e.code == 'user-not-found') {
        _throwFirebaseException(3, 'Usuário não encontrado');
      } else if (e.code == 'wrong-password') {
        _throwFirebaseException(4, 'Senha antiga incorreta');
      } else if (e.code == 'user-mismatch') {
        _throwFirebaseException(10, 'Email e/ou senha inválidos');
      } else if (e.code == 'requires-recent-login') {
        _throwFirebaseException(10,
            'Esta operação é confidencial e requer autenticação recente. Faça login novamente antes de tentar novamente esta solicitação');
      }
    }
  }

  @override
  Future<void> updateAlarm({required String alarm, required int days}) async {
    final instanceFireStore = FirebaseFirestore.instance;

    final users = instanceFireStore.collection('users');
    final docUser = users.doc(FirebaseAuth.instance.currentUser!.uid);

    if (alarm == 'redAlarm') {
      await docUser.update({'redAlarm': days});
    }
    if (alarm == 'yellowAlarm') {
      await docUser.update({'yellowAlarm': days});
    }
  }

  @override
  Future<void> removeItemList({
    required List<ProductModel> list,
    required int index,
    required String uidTeam,
  }) async {
    final instanceFireStore = FirebaseFirestore.instance;

    final teams = instanceFireStore.collection('teams');
    final docTeam = teams.doc(uidTeam);

    list.removeAt(index);

    await docTeam
        .update({'listProducts': list.map((e) => e.toJson()).toList()});
  }
}
