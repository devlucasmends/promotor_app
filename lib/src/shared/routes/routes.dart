import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/about/presentation/about_page.dart';
import 'package:promotor_app/src/features/auth/presentation/sign_in_page.dart';
import 'package:promotor_app/src/features/auth/presentation/sign_up_page.dart';
import 'package:promotor_app/src/features/home/presentation/home_page.dart';
import 'package:promotor_app/src/features/products/presentation/product_page.dart';
import 'package:promotor_app/src/features/settings/presentation/settings_page.dart';
import 'package:promotor_app/src/features/settings/presentation/update_name_page.dart';
import 'package:promotor_app/src/features/settings/presentation/update_password_page.dart';
import 'package:promotor_app/src/features/splash/presentation/splash_page.dart';
import 'package:promotor_app/src/features/team/presentation/team_management_page.dart';
import 'package:promotor_app/src/features/team/presentation/team_page.dart';
import 'package:promotor_app/src/shared/models/product_model.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/sign_in',
      builder: (context, state) => const SignInPage(),
      routes: [
        GoRoute(
          path: 'sign_up',
          builder: (context, state) => const SignUpPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/team',
      builder: (context, state) => const TeamPage(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'edit_product',
          builder: (context, state) {
            Map<String, dynamic> dataProduct =
                state.extra as Map<String, dynamic>;
            final listProduct = dataProduct['listProduct'];
            ProductModel productModel = listProduct[dataProduct['index']];
            return ProductPage(
              isAddPage: false,
              title: 'Edit Page',
              barCode: productModel.barCode,
              description: productModel.description,
              linkPhoto: productModel.linkPhoto,
              validate: productModel.validate,
              indexProduct: dataProduct['index'],
            );
          },
        ),
        GoRoute(
          path: 'add_product',
          builder: (context, state) =>
              const ProductPage(isAddPage: true, title: 'Adicionar Produto'),
        ),
        GoRoute(
          path: 'team_management',
          builder: (context, state) => const TeamManagementPage(),
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsPage(),
          routes: [
            GoRoute(
              path: 'update_name',
              builder: (context, state) => const UpdateNamePage(),
            ),
            GoRoute(
              path: 'update_password',
              builder: (context, state) => const UpdatePasswordPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
