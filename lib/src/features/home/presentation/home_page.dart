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
    super.initState();
    final homeRepository = Provider.of<HomeRepository>(context, listen: false);
    home = HomeStore(homeRepository);
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
              return ListTile(title: Text(listProducts[index].description));
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.go('/add_product');
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
