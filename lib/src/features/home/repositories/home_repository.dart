import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/models/team_model.dart';
import 'package:promotor_app/src/shared/services/firebase/firebase_service.dart';

class HomeRepository {
  final FirebaseService _firebaseService;

  HomeRepository(this._firebaseService);

  Future<TeamModel> getTeamCurrent() async {
    return await _firebaseService.getTeamCurrent();
  }

  Future<void> removeItemList({
    required List<ProductModel> list,
    required int index,
    required String uidTeam,
  }) async {
    await _firebaseService.removeItemList(
      list: list,
      index: index,
      uidTeam: uidTeam,
    );
  }
}
