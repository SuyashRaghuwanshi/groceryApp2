import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/widgets/widget_home_categories.dart';
import 'package:frontend/widgets/widget_home_products.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [const HomeCategoriesWidget(), HomeProductsWidget()],
        ),
      ),
    );
  }
}
