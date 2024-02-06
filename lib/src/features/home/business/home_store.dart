import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/features/home/business/home_state.dart';
import 'package:promotor_app/src/features/home/repositories/home_repository.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final HomeRepository _homeRepository;
  final AuthRepository _authRepository;

  @observable
  HomeState state = HomeInitState();

  @observable
  List<ProductModel> listProducts = [];

  @observable
  UserModel? _userModel;

  @computed
  UserModel? get userModel => _userModel;

  HomeStoreBase(this._homeRepository, this._authRepository) {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
    _userModel = await _authRepository.userLogged();
    await getListProducts();
  }

  @action
  Future<void> getListProducts() async {
    state = HomeLoadingState();
    listProducts = (await _homeRepository.getTeamCurrent()).listProducts;

    state = HomeSucessState();
  }

  @action
  int convertDate(String validity) {
    final day = int.parse(validity.substring(0, 2));
    final month = int.parse(validity.substring(3, 5));
    final year = int.parse(validity.substring(6));
    final currentDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime validateProduct = DateTime(year, month, day);

    final differenceDays = validateProduct.difference(currentDate).inDays;

    return differenceDays;
  }

  @action
  String getStringValitade(int differenceDays) {
    if (differenceDays < 0) {
      return 'Vencido a ${differenceDays * (-1)} Dias';
    } else if (differenceDays == 0) {
      return 'Vence Hoje';
    }
    return 'Vence em $differenceDays Dias';
  }

  @action
  String checkColorValidate(int differenceDays, int redAlert, int yellowAlert) {
    if (differenceDays < redAlert) {
      return 'redAlert';
    } else if (differenceDays < yellowAlert) {
      return 'yellowAlert';
    } else {
      return 'safeZone';
    }
  }

  @action
  Future<void> removeItemList({
    required List<ProductModel> list,
    required int index,
    required String uidTeam,
  }) async {
    state = HomeLoadingState();
    await _homeRepository.removeItemList(
      list: list,
      index: index,
      uidTeam: uidTeam,
    );
    state = HomeSucessState();
  }
}
