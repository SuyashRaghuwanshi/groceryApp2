import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/dashboard_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/product_details_page.dart';
import 'package:frontend/pages/products_page.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:frontend/utils/shared_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Widget _defaultHome = const LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ignore: no_leading_underscores_for_local_identifiers
  bool _result = await SharedService.isLogged();
  if (_result) {
    _defaultHome = DashBoardPage();
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const RegisterPage(),
      navigatorKey: navigatorKey,
      routes: <String, WidgetBuilder>{
        '/': (context) => _defaultHome,
        '/register': (BuildContext context) => const RegisterPage(),
        '/home': (BuildContext context) => HomePage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/products': (BuildContext context) => ProductsPage(),
        '/product-details':
            (BuildContext context) => const ProductDetailsPage(),
      },
    );
  }
}
