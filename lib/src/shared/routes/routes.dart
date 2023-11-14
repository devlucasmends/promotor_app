import 'package:go_router/go_router.dart';
import 'package:promotor_app/src/features/products/presentation/add_product_page.dart';
import 'package:promotor_app/src/features/auth/presentation/sign_in_page.dart';
import 'package:promotor_app/src/features/auth/presentation/sign_up_page.dart';
import 'package:promotor_app/src/features/home/presentation/home_page.dart';
import 'package:promotor_app/src/features/team/presentation/team_page.dart';

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
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
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/add_product',
      builder: (context, state) => const AddProductPage(),
    ),
  ],
);
