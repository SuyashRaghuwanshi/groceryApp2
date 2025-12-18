import 'package:flutter/material.dart';
import 'package:frontend/utils/shared_service.dart';
import 'package:frontend/widgets/widget_home_categories.dart';
import 'package:frontend/widgets/widget_home_products.dart';
import 'package:frontend/widgets/widget_home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Implement search functionality
              SharedService.logout(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const HomeSliderWidget(),
          const HomeCategoriesWidget(),
          HomeProductsWidget(),
        ],
      ),
    );
  }
}
