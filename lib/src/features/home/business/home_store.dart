import 'package:mobx/mobx.dart';
import 'package:promotor_app/src/features/home/business/home_state.dart';
import 'package:promotor_app/src/features/home/repositories/home_repository.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final HomeRepository _homeRepository;

  @observable
  HomeState state = HomeInitState();

  @observable
  List<ProductModel> listProducts = [];

  HomeStoreBase(this._homeRepository) {
    _initialize();
  }

  @action
  Future<void> _initialize() async {
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
}
