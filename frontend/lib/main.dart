import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/pages/products_page.dart';
import 'package:frontend/pages/register_page.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const RegisterPage(),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => const RegisterPage(),
        '/products': (BuildContext context) => ProductsPage(),
      },
    );
  }
}
