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
    listProducts = await _homeRepository.getListProducts();
    state = HomeSucessState();
  }

  @action
  convertDate(String validate) {
    final validateTra = validate.replaceAll(RegExp(r'[^0-9]'), '');
    final ta = validate.split('/');

    final currentDate = DateTime.now();
    // DateTime validateProduct = DateTime.parse(validate);

    // final x = validateProduct.difference(currentDate);
    print('as');
  }
}
