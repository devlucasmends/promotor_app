import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/home/business/home_state.dart';
import 'package:promotor_app/src/features/home/business/home_store.dart';
import 'package:promotor_app/src/features/home/repositories/home_repository.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeStore home;
  List<ProductModel> listProducts = [];

  @override
  void initState() {
    final homeRepository = Provider.of<HomeRepository>(context, listen: false);
    home = HomeStore(homeRepository);
    home.getListProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(child: Observer(builder: (_) {
        if (home.state is HomeSucessState) {
          listProducts = home.listProducts;
          return ListView.builder(
            itemCount: listProducts.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text('LEADING'),
                title: Text(listProducts[index].description),
                subtitle: Text('SUBTITLE'),
                trailing: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Map<String, dynamic> dataProduct = {
                        'listProduct': listProducts,
                        'index': index,
                      };

                      GoRouter.of(context)
                          .push('/home/edit_product', extra: dataProduct)
                          .whenComplete(
                            () => home.getListProducts(),
                          );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.go('/home/add_product');
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
