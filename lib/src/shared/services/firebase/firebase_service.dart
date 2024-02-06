import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/models/team_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';

abstract class FirebaseService {
  Future<void> initialize();

  Future<void> signIn({required String email, required String password});

  Future<void> signOut();

  Future<void> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  });

  Future<void> createTeam();

  Future<void> setTeam({required uidTeam});

  Future<void> addUserListTeam({required uidTeam});

  Future<void> addProduct({required ProductModel productModel});

  Future<void> editProduct(
      {required ProductModel product,
      required int index,
      required String idTeamCurrent});

  Future<TeamModel> getTeamCurrent();

  Future<String> addImageStorage(
      {required String path,
      required String identifier,
      required UserModel user});

  Future<UserModel?> userLogged();

  Future<void> removeUserTeam({
    required String uidTeam,
    required String uidUser,
    required int index,
  });

  Future<UserModel> getUser();

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<void> removeItemList({
    required List<ProductModel> list,
    required int index,
    required String uidTeam,
  });

  Future<void> updateAlarm({required String alarm, required int days});
}
