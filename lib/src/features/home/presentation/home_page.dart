import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/home/business/home_state.dart';
import 'package:promotor_app/src/features/home/business/home_store.dart';
import 'package:promotor_app/src/features/home/repositories/home_repository.dart';
import 'package:promotor_app/src/shared/business/auth/auth_store.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';
import 'package:promotor_app/src/shared/models/user_model.dart';
import 'package:promotor_app/src/shared/repositories/auth/auth_repository.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeStore home;
  late AuthStore authStore;
  UserModel? userModel;
  List<ProductModel> listProducts = [];
  TextStyle styleText = const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  int differenceDays = 0;

  @override
  void initState() {
    final homeRepository = Provider.of<HomeRepository>(context, listen: false);
    home = HomeStore(homeRepository);
    final authRepository = Provider.of<AuthRepository>(context, listen: false);
    authStore = AuthStore(authRepository);

    home.getListProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      drawer: Drawer(
        width: 250,
        child: ListView(
          children: [
            componentListTile(
              text: 'Adicionar Produto',
              path: '/home/add_product',
              icon: Icons.add_box_rounded,
            ),
            componentListTile(
              text: 'Time',
              path: '/home/team_management',
              icon: Icons.group,
            ),
            componentListTile(
              text: 'Sobre',
              path: '/about',
              icon: Icons.info_outline_rounded,
            ),
            componentListTile(
              text: 'Configurações',
              path: '/home/settings',
              icon: Icons.settings,
            ),
            componentListTile(
              text: 'Sair',
              path: '/logout',
              icon: Icons.logout,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              authStore.signOut();
              context.go('/sign_in');
            },
            child: const Text('Sair'),
          ),
        ],
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            if (home.state is HomeSucessState) {
              listProducts = home.listProducts;
              return ListView.builder(
                itemCount: listProducts.length,
                itemBuilder: (context, index) {
                  differenceDays = home.convertDate(
                    listProducts[index].validate,
                  );
                  return ListTile(
                    leading: const Text('LEADING'),
                    title: Text(listProducts[index].description),
                    subtitle: Text(
                      home.getStringValitade(
                        differenceDays,
                      ),
                      style: TextStyle(
                        color: Color(
                          getColorValidate(
                            differenceDays,
                          ),
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          context.push('/home/add_product').whenComplete(
                () => home.getListProducts(),
              );
        },
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  int getColorValidate(int differenceDays) {
    final checkColor = home.checkColorValidate(differenceDays,
        authStore.userModel!.redAlert, authStore.userModel!.yellowAlert);
    if (checkColor == 'redAlert') {
      return 0xFFFF0000;
    } else if (checkColor == 'yellowAlert') {
      return 0xFFFFE500;
    } else {
      return 0xFF00FF1A;
    }
  }

  Widget componentListTile(
      {required String text, required String path, required IconData icon}) {
    return SizedBox(
      height: 50,
      child: ListTile(
        minLeadingWidth: 5,
        leading: Icon(icon),
        title: Text(
          text,
          style: styleText,
        ),
        onTap: () {
          print(path);
          if (path == '/logout') {
            authStore.signOut();
            context.go('/sign_in');
          } else {
            context.push(path).whenComplete(
                  () => home.getListProducts(),
                );
          }
        },
      ),
    );
  }
}
